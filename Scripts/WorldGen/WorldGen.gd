class_name WorldGen extends Node3D

enum WorldGenStatus
{
	STANDBY = 0,
	CREATING_TEXTURES = 1,
	GENERATING_CHUNKS = 2
}

@export_category("Chunk options")
@export var DisabledChunkPositions: Array[WorldGen_DisabledChunkPosition] = []
@export var ChunkSize: Vector3i = Vector3i.ONE
@export var Chunks: Array[PackedScene] = []
@export var GenerateX: bool = true
@export var GenerateZ: bool = true
var ChunkPool: Array[Node3D] = []
var LoadedChunks: Dictionary[Vector3i, Node3D] = {}
var InstancedChunkParent: Node3D = null
var ClonedChunkParent: Node3D = null
var NavigationRegion: NavigationRegion3D = null

@export_category("Map options")
@export var LevelName: String = ""
@export var Maps: Array[Texture2D] = []
@export var BlackTextureInsteadOfNoise: bool = false
var LoadedMaps: Dictionary[int, Texture2D] = {}
var LoadedImages: Dictionary[int, Image] = {}
@export var MultipleFloors: bool = true

@export_category("Player options")
@export var Player: CharacterMovement = null
@export var PlayerSpawnMin: Vector3i = Vector3i.ZERO
@export var PlayerSpawnMax: Vector3i = Vector3i(1000, 10, 1000)
@export var PlayerSpawnOffset: Vector3 = Vector3.ZERO
@export var PlayerSpawnFullRandom: bool = true
var PlayerSpawns: Array[Vector3] = []
@export var PlayerDieFalling: bool = false
@export var PlayerDieFallingDistance: float = 100

@export_category("Other options")
var Generate: bool = false
var GenerationCompleted: bool = true
var RNG: RandomNumberGenerator = RandomNumberGenerator.new()
var FNL: FastNoiseLite = FastNoiseLite.new()

func SetSeed(Seed: int) -> void:
	RNG.seed = Seed
	FNL.seed = Seed

func GetChunkIndex(NoiseBrightness: float) -> int:
	return int(round(NoiseBrightness * (ChunkPool.size() - 1)))

func GetPixelInImage(
	Img: Image,
	WorldPos: Vector2i,
	FloorSize: Vector2i
) -> Color:
	var texturePixelPos = Vector2i(
		int(WorldPos.x) % FloorSize.x,
		int(WorldPos.y) % FloorSize.y
	)
	
	if (texturePixelPos.x < 0): texturePixelPos.x += FloorSize.x
	if (texturePixelPos.y < 0): texturePixelPos.y += FloorSize.y
	
	return Img.get_pixel(texturePixelPos.x, texturePixelPos.y)

func UpdateChunks(
	SizeX: int = 0,
	SizeZ: int = 0
) -> void:
	if (!Generate && !GenerationCompleted):
		return

	GenerationCompleted = false
	var currentChunk = Vector3i(
		roundi(Player.global_position.x / ChunkSize.x),
		roundi(Player.global_position.y / ChunkSize.y),
		roundi(Player.global_position.z / ChunkSize.z)
	)

	if (SizeX <= 0):
		SizeX = Globals.Instance.ViewDistance

	if (SizeZ <= 0):
		SizeZ = Globals.Instance.ViewDistance

	var extentX = int(SizeX / 2)
	var extentZ = int(SizeZ / 2)

	for coords in LoadedChunks.keys():
		var offset = coords - currentChunk

		if (absi(offset.x) > extentX + 1 || absi(offset.z) > extentZ + 1 || absi(offset.y) > 2):
			var chunkToRemove = LoadedChunks[coords]

			ClonedChunkParent.remove_child(chunkToRemove)
			chunkToRemove.queue_free()
			LoadedChunks.erase(coords)

	for floorID in LoadedMaps.keys():
		if (abs(floorID - currentChunk.y) > 5):
			LoadedMaps.erase(floorID)
			LoadedImages.erase(floorID)

	var floors = []
	var genX = []
	var genZ = []

	if (MultipleFloors):
		floors = [-1, 0, 1]
	else:
		floors = [0]
	
	if (GenerateX):
		genX = range(-SizeX / 2, SizeX / 2 + 1)
	else:
		genX = [0]
	
	if (GenerateZ):
		genZ = range(-SizeZ / 2, SizeZ / 2 + 1)
	else:
		genZ = [0]
	
	for y in floors:
		var floorTexture: Texture2D = null
		var floorImage: Image = null

		if (Maps.size() > 0):
			var floorKey = currentChunk.y + y

			if (floorKey in LoadedMaps):
				floorTexture = LoadedMaps[floorKey]
				floorImage = LoadedImages[floorKey]
			else:
				floorTexture = Maps[RNG.randi_range(0, Maps.size() - 1)]
				floorImage = floorTexture.get_image()
				LoadedMaps[floorKey] = floorTexture
				LoadedImages[floorKey] = floorImage
		else:
			floorImage = FNL.get_image(ChunkSize.x * 100, ChunkSize.z * 100)
			floorTexture = ImageTexture.create_from_image(floorImage)

			Maps.append(floorTexture)
		
		var floorSize = Vector2i(floorTexture.get_width(), floorTexture.get_height())
		
		for x in genX:
			for z in genZ:
				var coords = Vector3i(
					currentChunk.x + x,
					currentChunk.y + y,
					currentChunk.z + z
				)
				var inDisabledChunk = false
				
				for disabledChunk in DisabledChunkPositions:
					if (
						(coords.x >= disabledChunk.MinPosition.x && coords.x <= disabledChunk.MaxPosition.x) &&
						(coords.y >= disabledChunk.MinPosition.y && coords.y <= disabledChunk.MaxPosition.y) &&
						(coords.z >= disabledChunk.MinPosition.z && coords.z <= disabledChunk.MaxPosition.z)
					):
						inDisabledChunk = true
						break
				
				if (coords in LoadedChunks || inDisabledChunk):
					continue
				
				var pixelCurrent = GetPixelInImage(
					floorImage,
					Vector2i(coords.x * ChunkSize.x, coords.z * ChunkSize.z),
					floorSize
				)
				var pixelLeft = GetPixelInImage(
					floorImage,
					Vector2i((coords.x + 1) * ChunkSize.x, coords.z * ChunkSize.z),
					floorSize
				)
				var pixelRight = GetPixelInImage(
					floorImage,
					Vector2i((coords.x - 1) * ChunkSize.x, coords.z * ChunkSize.z),
					floorSize
				)
				var pixelBack = GetPixelInImage(
					floorImage,
					Vector2i(coords.x * ChunkSize.x, (coords.z - 1) * ChunkSize.z),
					floorSize
				)
				var pixelFront = GetPixelInImage(
					floorImage,
					Vector2i(coords.x * ChunkSize.x, (coords.z + 1) * ChunkSize.z),
					floorSize
				)
				
				var chunk: Node3D = ChunkPool[GetChunkIndex(pixelCurrent.g)].duplicate()
				chunk.position = coords * ChunkSize
				
				ClonedChunkParent.add_child(chunk)
				LoadedChunks[coords] = chunk
				
				if ("Init" in chunk && "SetSeed" in chunk):
					chunk.BASE_WORLD_GENERATOR = self
					chunk.IsPlayerSpawn = pixelCurrent.b == 1 && pixelCurrent.b != pixelCurrent.g
					chunk.IsEntitySpawn = pixelCurrent.r == 1 && pixelCurrent.r != pixelCurrent.g
					chunk.Coords = coords
					chunk.Chunk_Left = GetChunkIndex(pixelLeft.g)
					chunk.Chunk_Right = GetChunkIndex(pixelRight.g)
					chunk.Chunk_Front = GetChunkIndex(pixelFront.g)
					chunk.Chunk_Back = GetChunkIndex(pixelBack.g)
					chunk.SetSeed(RNG.randi() + coords.x * 2 + coords.z * 4 - coords.y * 8)
					chunk.Init()

					if (chunk.IsPlayerSpawn && PlayerSpawns.size() < 512):
						PlayerSpawns.append(chunk.position)
	
	GenerationCompleted = true
	call_deferred("RebuildNavigationMesh")

func RebuildNavigationMesh() -> void:
	var nav_mesh := NavigationMesh.new()
	nav_mesh.agent_radius = 0.4
	nav_mesh.agent_height = 1.8
	nav_mesh.agent_max_climb = 0.3
	var half := Vector2(ChunkSize.x, ChunkSize.z) * 0.5
	var wall_margin := 0.6
	var verts := PackedVector3Array()
	var idx := 0
	for coords in LoadedChunks.keys():
		var chunk: Node3D = LoadedChunks[coords]
		var origin := Vector3(coords.x * ChunkSize.x, 0.0, coords.z * ChunkSize.z)
		var min_x := -half.x
		var max_x := half.x
		var min_z := -half.y
		var max_z := half.y
		var has_wall_front := _is_wall_active(chunk, "FrontWall")
		var has_wall_back := _is_wall_active(chunk, "BackWall")
		var has_wall_left := _is_wall_active(chunk, "LeftWall")
		var has_wall_right := _is_wall_active(chunk, "RightWall")
		if (has_wall_front):
			max_z = half.y - wall_margin
		if (has_wall_back):
			min_z = -half.y + wall_margin
		if (has_wall_left):
			max_x = half.x - wall_margin
		if (has_wall_right):
			min_x = -half.x + wall_margin
		if (min_x >= max_x || min_z >= max_z):
			continue
		verts.append(origin + Vector3(min_x, 0.0, min_z))
		verts.append(origin + Vector3(max_x, 0.0, min_z))
		verts.append(origin + Vector3(max_x, 0.0, max_z))
		verts.append(origin + Vector3(min_x, 0.0, max_z))
		nav_mesh.add_polygon(PackedInt32Array([idx, idx + 1, idx + 2, idx + 3]))
		idx += 4
	nav_mesh.set_vertices(verts)
	if (verts.size() > 0):
		NavigationRegion.navigation_mesh = nav_mesh


func _is_wall_active(chunk: Node3D, wall_name: String) -> bool:
	var wall := chunk.get_node_or_null(wall_name)
	if (wall == null):
		return false
	return wall.visible

func SpawnPlayer() -> void:
	var spawnPos = Vector3.ZERO
	
	if (PlayerSpawns.size() > 0):
		var idx = (randi() if (PlayerSpawnFullRandom) else RNG.randi()) % PlayerSpawns.size()
		spawnPos = PlayerSpawns[idx]
	else:
		spawnPos = Vector3(
			randi_range(PlayerSpawnMin.x, PlayerSpawnMax.x) if (PlayerSpawnFullRandom) else RNG.randi_range(PlayerSpawnMin.x, PlayerSpawnMax.x),
			randi_range(PlayerSpawnMin.y, PlayerSpawnMax.y) if (PlayerSpawnFullRandom) else RNG.randi_range(PlayerSpawnMin.y, PlayerSpawnMax.y),
			randi_range(PlayerSpawnMin.z, PlayerSpawnMax.z) if (PlayerSpawnFullRandom) else RNG.randi_range(PlayerSpawnMin.z, PlayerSpawnMax.z)
		)
	
	Player.global_position = spawnPos + PlayerSpawnOffset
	Player.Spawned = true

func _ready() -> void:
	FNL.noise_type = FastNoiseLite.TYPE_PERLIN
	FNL.frequency = 0.02
	FNL.fractal_type = FastNoiseLite.FRACTAL_FBM
	FNL.fractal_octaves = 5
	
	InstancedChunkParent = Node3D.new()
	InstancedChunkParent.name = "Instanced"
	add_child(InstancedChunkParent)
	
	ClonedChunkParent = Node3D.new()
	ClonedChunkParent.name = "Cloned"
	add_child(ClonedChunkParent)

	NavigationRegion = NavigationRegion3D.new()
	NavigationRegion.name = "NavigationRegion"
	add_child(NavigationRegion)
	
	for chunk in Chunks:
		var instance: Node3D = chunk.instantiate()
		instance.position = Vector3(-9999999, -9999999, -9999999)
		InstancedChunkParent.add_child(instance)
		
		ChunkPool.append(instance)
	
	Player.process_mode = Node.PROCESS_MODE_DISABLED
	
	if (!Generate):
		SetSeed(randi())
		Generate = true
	
	if (Generate):
		var hasMaps = Maps.size() > 0
		
		SpawnPlayer()
		UpdateChunks()
		
		if (hasMaps):
			SpawnPlayer()
		
		Player.process_mode = Node.PROCESS_MODE_INHERIT
	
	var genTimer = Timer.new()
	genTimer.autostart = true
	genTimer.one_shot = false
	genTimer.wait_time = clampf(Globals.Instance.GenerationTime, 0.5, 20)
	genTimer.timeout.connect(UpdateChunks)
	add_child(genTimer)

func _physics_process(_Delta: float) -> void:
	if (PlayerDieFalling && Player.position.y <= -PlayerDieFallingDistance):
		Player.Die()
