class_name Conn extends Node

const VERSION: int = 220000
const TRANSFER_RATE: int = 8192 * 1024
const CHUNK_END: String = "--END--"
const CLOSE_MESSAGE: String = "close"
const DEFAULT_PORT: int = 8060
const RECEIVE_TIMEOUT_MS: int = 30000
const DEFAULT_CONFIG: Dictionary = {
	"Encryption_PublicKey": null,
	"Encryption_PrivateKey": null,
	"Encryption_PrivateKeyPassword": "changeme",
	"Encryption_Threads": 1,
	"Encryption_RSASize": 4096,
	"Encryption_Hash": "sha512",
	"Service_DefaultAPIKey": "nokey",
	"PingInterval": 20.0
}

static var ConfigPath: String = ""
static var Config: Dictionary = {}
static var Peer: WebSocketPeer = null
static var ServerPublicKey: String = ""

func _ready() -> void:
	Globals.CheckInstance()
	LoadConfig()

func _process(_delta: float) -> void:
	if (Peer != null):
		Peer.poll()

func LoadConfig() -> void:
	if (!Config.is_empty()):
		return

	ConfigPath = Globals.ParsePath("[$GAME_CONFIG_DIR]/I4.0_config.json")
	Config = DEFAULT_CONFIG.duplicate(true)

	if (FileAccess.file_exists(ConfigPath)):
		var file = FileAccess.open(ConfigPath, FileAccess.READ)

		if (file != null):
			var saved = JSON.parse_string(file.get_as_text())
			file.close()

			if (saved is Dictionary):
				for key in saved.keys():
					Config[key] = saved[key]

	SaveConfig()

func SaveConfig() -> void:
	if (ConfigPath.is_empty()):
		ConfigPath = Globals.ParsePath("[$GAME_CONFIG_DIR]/I4.0_config.json")

	var file = FileAccess.open(ConfigPath, FileAccess.WRITE)

	if (file == null):
		push_error("Could not save I4.0 config file.")
		return

	file.store_string(JSON.stringify(Config))
	file.close()

func IsConnected() -> bool:
	return Peer != null && Peer.get_ready_state() == WebSocketPeer.STATE_OPEN

func OpenConnection(Host: String, Port: int, Secure: bool = true) -> bool:
	Close()

	Peer = WebSocketPeer.new()
	Peer.connect_to_url(("wss://" if Secure else "ws://") + Host + ":" + str(Port))

	while (Peer != null && Peer.get_ready_state() == WebSocketPeer.STATE_CONNECTING && is_inside_tree()):
		await get_tree().process_frame

	if (!is_inside_tree() || Peer == null || Peer.get_ready_state() != WebSocketPeer.STATE_OPEN):
		push_warning("Could not connect to server %s:%d." % [Host, Port])
		Peer = null
		return false

	ServerPublicKey = await SendAndReceive("get_public_key")

	if (ServerPublicKey.is_empty()):
		Close()
		return false

	return true

func Close() -> void:
	if (Peer == null):
		return

	if (Peer.get_ready_state() == WebSocketPeer.STATE_OPEN):
		Peer.send_text(CLOSE_MESSAGE)
		Peer.close()

	Peer = null

func Send(Data: String) -> void:
	if (!IsConnected()):
		push_error("Socket is not connected.")
		return

	var i = 0

	while (i < Data.length()):
		Peer.send_text(Data.substr(i, TRANSFER_RATE))
		i += TRANSFER_RATE

	Peer.send_text(CHUNK_END)

func Receive() -> String:
	if (!IsConnected()):
		push_error("Socket is not connected.")
		return ""

	var data = ""
	var deadline = Time.get_ticks_msec() + RECEIVE_TIMEOUT_MS

	while (Time.get_ticks_msec() < deadline):
		if (Peer == null || Peer.get_ready_state() != WebSocketPeer.STATE_OPEN):
			return ""

		if (Peer.get_available_packet_count() > 0):
			var chunk = Peer.get_packet().get_string_from_utf8()

			if (chunk == CHUNK_END):
				return data

			data += chunk
		else:
			await get_tree().process_frame

	push_warning("Timed out while receiving data from the I4.0 server.")

	return data

func SendAndReceive(Data: String) -> String:
	Send(Data)
	return await Receive()

func Request(ModelName: String, Service: String, PromptConversation: Array = [], PromptParameters: Dictionary = {}, UserParameters: Dictionary = {}) -> Array[Dictionary]:
	var tokens: Array[Dictionary] = []

	if (!IsConnected()):
		push_error("Socket is not connected.")
		return tokens

	var content := {
		"model_name": ModelName,
		"service": Service,
		"key": Config["Service_DefaultAPIKey"],
		"prompt": {
			"conversation": PromptConversation,
			"parameters": PromptParameters
		},
		"user_parameters": UserParameters
	}
	var request := {
		"hash": Config["Encryption_Hash"],
		"public_key": ServerPublicKey,
		"version": VERSION,
		"content": JSON.stringify(content)
	}

	Send(JSON.stringify(request))

	while (true):
		var raw = await Receive()

		if (raw.is_empty()):
			break

		var token = JSON.parse_string(raw)

		if (token is Dictionary):
			tokens.append(token)

			if (token.has("redirect_to")):
				break

			if (token.has("ended") && token["ended"]):
				break

	return tokens

func GetAvailableModels() -> Array[String]:
	var models: Array[String] = []

	for token in await Request("", "get_available_models"):
		if (token.has("models") && token["models"] is Array):
			for model in token["models"]:
				if (model is String):
					models.append(model)

		if (token.has("errors") && token["errors"] is Array && !token["errors"].is_empty()):
			push_error("Unexpected server error(s): %s" % [str(token["errors"])])
			models.clear()
			break

	return models

func ConnectToServer(Models: Array[String]) -> bool:
	var modelFound := false

	if (IsConnected()):
		modelFound = await __model_available__(Models)

		if (modelFound):
			return true

	for server in Globals.Instance.I4_Servers:
		var srv := server
		var port := DEFAULT_PORT
		var separatorIndex := server.find(":")
		var secure := true

		print("Connecting to ", server)

		if (separatorIndex != -1):
			port = int(server.substr(separatorIndex + 1))
			srv = server.substr(0, separatorIndex)

		if (!await OpenConnection(srv, port, secure)):
			if (!await OpenConnection(srv, port, !secure)):
				continue

		print("Finding ", Models)
		modelFound = await __model_available__(Models)

		if (modelFound):
			break

	if (!modelFound):
		push_error("Could not connect to server of find any of the models.")

	return modelFound

func __model_available__(Models: Array[String]) -> bool:
	var available := await GetAvailableModels()

	for model in Models:
		if (model in available):
			return true

	return false
