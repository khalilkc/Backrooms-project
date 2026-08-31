class_name CharacterMovement extends CharacterBody3D

const INTERACTION_MAX_LENGTH: float = 5
const INTERACTION_PARENT_LENGTH: int = 4
var WHISTLING_SOUNDS: Dictionary[Globals.SoundID, AudioStream] = {
	Globals.SoundID.WHISTLE_1: load("res://Audio/Whistling 1.wav"),
	Globals.SoundID.WHISTLE_2: load("res://Audio/Whistling 2.wav")
}

@export_category("Gravity")
@export var GravityMultiplier: float = 1
var FallTime: float = 0

@export_category("Speed")
@export var WalkSpeed: float = 2.7
@export var RunSpeed: float = 5.4
@export var CrouchSpeed: float = 1.4
@export_range(1, 30, 0.1) var GroundAcceleration: float = 11
@export_range(0.5, 12, 0.1) var AirAcceleration: float = 2.4
var CurrentSpeed: float = 0
var CurrentDirection: Vector3 = Vector3.ZERO

@export_category("Jump")
@export var JumpVelocity: float = 4.6
@export_range(0, 0.4, 0.01) var CoyoteTime: float = 0.12
@export_range(0, 0.4, 0.01) var JumpBufferTime: float = 0.15
@export_range(1, 20, 0.5) var LandingRefSpeed: float = 9

@export_category("Crouch")
@export_range(0.3, 0.8, 0.01) var CrouchHeightRatio: float = 0.55
@export_range(1, 25, 0.1) var CrouchBlendSpeed: float = 10
@export var EyeHeightStanding: float = 1.75
@export var EyeHeightCrouched: float = 1.02

@export_category("Health")
static var Health: float = 100

@export_category("Sanity")
var Sanity: float = 100
@export var SanityDecreaseMultiplier: float = 0.075
@export var SanityIncreasyMultiplier: float = 1

@export_category("Inventory")
var InventoryItems: Array[InventoryItem] = []

@export_category("Sound")
var Sounds: Dictionary[String, AudioStreamPlayer3D] = {}

@export_category("Head")
@export var Head: Node3D = null
@export var MaxLookAngle: Vector2 = Vector2(-85, 80)

@export_category("Look Feel")
@export_range(4, 40, 0.5) var LookSmoothing: float = 24
@export_range(0, 6, 0.1) var StrafeRollDegrees: float = 1.9
@export_range(0, 8, 0.1) var YawErrorRollDegrees: float = 2.6
@export_range(0, 6, 0.1) var YawErrorMaxDegrees: float = 2.2

@export_category("Head Bob")
@export_range(2, 14, 0.1) var BobFrequencyWalk: float = 7.6
@export_range(1, 2, 0.01) var BobFrequencySprintScale: float = 1.32
@export_range(0, 0.15, 0.001) var BobAmplitudeWalk: float = 0.042
@export_range(0, 0.2, 0.001) var BobAmplitudeSprint: float = 0.078
@export_range(0, 1, 0.01) var BobCrouchMultiplier: float = 0.55
@export_range(1, 20, 0.1) var BobWeightSmoothing: float = 9

@export_category("Breathing")
@export_range(0.3, 3, 0.01) var BreathFrequency: float = 1.15
@export_range(0, 0.03, 0.0005) var BreathPitchDegrees: float = 0.0038
@export_range(0, 0.05, 0.0005) var BreathLift: float = 0.006

@export_category("Camera Feel")
@export_range(50, 110, 1) var BaseFOV: float = 78
@export_range(0, 20, 0.5) var SprintFOVBoost: float = 7
@export_range(1, 20, 0.1) var FOVSmoothing: float = 7
@export_range(0, 0.6, 0.005) var LandDipDistance: float = 0.17
@export_range(20, 400, 1) var LandSpringStiffness: float = 130
@export_range(4, 60, 0.5) var LandSpringDamping: float = 16
@export_range(0, 10, 0.1) var LandPitchKickDegrees: float = 2.6
@export_range(0, 10, 0.1) var LandPitchRecovery: float = 7

@export_category("Other")
var Spawned: bool = false
var Running: bool = false

var __camera: Camera3D
var __collider: CollisionShape3D
var __initRadius: float = 0
var __initHeight: float = 0

var __targetYaw: float = 0
var __targetPitch: float = 0
var __smoothYaw: float = 0
var __smoothPitch: float = 0
var __bobPhase: float = 0
var __bobWeight: float = 0
var __crouchAmount: float = 0
var __coyote: float = 0
var __jumpBuffer: float = 0
var __wasOnFloor: bool = false
var __springPos: float = 0
var __springVel: float = 0
var __landPitch: float = 0
var __breathPhase: float = 0
var __sprintMix: float = 0
var __bobLateral: float = 0
var __bobVertical: float = 0
var __eyeCurrent: float = 1.75

func ChangeLevel(Level: PackedScene) -> void:
	SceneLoader.goto_scene(Level.resource_path)

func __cast_ray__(From: Vector3, Direction: Vector3, Length: float) -> CollisionObject3D:
	var hit = get_world_3d().direct_space_state.intersect_ray(PhysicsRayQueryParameters3D.create(
		From,
		From - Direction * Length
	))

	if (hit):
		return hit.collider

	return null

func PlaySound(Type: String, Sound: AudioStream) -> void:
	if (Type not in Sounds || Sounds[Type] == null || Sound == null):
		return

	if (Sounds[Type].playing && Sounds[Type].stream == Sound):
		return
	elif (Sounds[Type].playing):
		StopSound(Type)

	var BindedStopSound = StopSound.bind(Type)

	if (Sounds[Type].finished.is_connected(BindedStopSound)):
		Sounds[Type].finished.disconnect(BindedStopSound)

	Sounds[Type].finished.connect(BindedStopSound)

	Sounds[Type].stream = Sound
	Sounds[Type].play()

func StopSound(Type: String) -> void:
	if (Type not in Sounds || Sounds[Type] == null):
		return

	Sounds[Type].stop()
	Sounds[Type].stream = null

func Die() -> void:
	print("Dead")  # TODO

func Inv_FindFirstItemWithTag(Tag: String) -> InventoryItem:
	for item in InventoryItems:
		if (Tag in item.Tags):
			return item

	return null

func Inv_AddItem(Item: InventoryItem) -> void:
	InventoryItems.append(Item)

	Item.process_mode = Node.PROCESS_MODE_DISABLED
	Item.hide()
	Item.reparent(self)

func Inv_UseItem(Item: InventoryItem) -> void:
	if (Item in InventoryItems && Item.MaxUses <= 1):
		Item.MaxUses -= 1

		if (Item.MaxUses <= 1):
			InventoryItems.erase(Item)

func RequestInteract() -> void:
	var hit = __cast_ray__(Head.global_position, Head.global_basis.z, INTERACTION_MAX_LENGTH)

	if (!hit):
		return

	var interactibleObj = hit
	var parentIdx = 0

	while (interactibleObj != null && "Interact" not in interactibleObj && parentIdx <= INTERACTION_PARENT_LENGTH):
		interactibleObj = interactibleObj.get_parent_node_3d()
		parentIdx += 1

	if (interactibleObj != null && "Interact" in interactibleObj):
		interactibleObj.Interact()

func __exp_weight__(Rate: float, Delta: float) -> float:
	return 1 - exp(-Rate * Delta)

func __can_stand__() -> bool:
	var capsule = CapsuleShape3D.new()
	capsule.radius = __initRadius
	capsule.height = __initHeight

	var query = PhysicsShapeQueryParameters3D.new()
	query.shape = capsule
	query.transform = Transform3D(Basis.IDENTITY, global_position + Vector3(0, __initHeight * 0.5, 0))
	query.collision_mask = collision_mask
	query.exclude = [get_rid()]

	return get_world_3d().direct_space_state.intersect_shape(query, 1).is_empty()

func _init() -> void:
	Globals.CheckInstance()
	Sounds = Globals.CreateSoundPlayers(true, self)

func _ready() -> void:
	__camera = $Head/Camera3D
	__collider = $PlayerCollider
	__initRadius = __collider.shape.radius
	__initHeight = __collider.shape.height

	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	__camera.fov = BaseFOV
	rotation.y = __targetYaw

func _input(Event: InputEvent) -> void:
	if (Event is InputEventMouseMotion):
		var s = Globals.Instance.Sensibility * 0.01

		__targetYaw = wrapf(__targetYaw - Event.relative.x * s, -PI, PI)
		__targetPitch = clampf(__targetPitch - Event.relative.y * s, deg_to_rad(MaxLookAngle.x), deg_to_rad(MaxLookAngle.y))

func _process(Delta: float) -> void:
	if (Input.mouse_mode != Input.MOUSE_MODE_CAPTURED):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

	if (Input.is_action_just_pressed("act_interact")):
		RequestInteract()

	if (Input.is_action_just_pressed("act_whistling")):
		var id = WHISTLING_SOUNDS.keys()[randi() % WHISTLING_SOUNDS.size()]
		PlaySound("Whistle", WHISTLING_SOUNDS[id])

	var k = __exp_weight__(LookSmoothing, Delta)
	__smoothYaw = lerp_angle(__smoothYaw, __targetYaw, k)
	__smoothPitch = lerpf(__smoothPitch, __targetPitch, k)

	rotation.y = __smoothYaw

	__breathPhase = fmod(__breathPhase + BreathFrequency * TAU * Delta, TAU)
	var breathAmp = (1 - __bobWeight) * (1.0 if __wasOnFloor else 0.25)
	var breathPitch = sin(__breathPhase) * deg_to_rad(BreathPitchDegrees) * 10 * breathAmp
	var breathLift = sin(__breathPhase) * BreathLift * breathAmp

	__landPitch *= exp(-LandPitchRecovery * Delta)

	var yawErr = angle_difference(rotation.y, __targetYaw)
	var strafeRoll: float = 0

	if (CurrentDirection.length_squared() > 0.0001):
		strafeRoll = clampf(-CurrentDirection.normalized().dot(transform.basis.x), -1, 1) * deg_to_rad(StrafeRollDegrees) * __bobWeight

	var errRatio = clampf(rad_to_deg(yawErr) / YawErrorMaxDegrees, -1, 1)
	var errRoll = errRatio * deg_to_rad(YawErrorRollDegrees)
	var bobRoll = sin(__bobPhase) * deg_to_rad(1.4) * __bobWeight

	Head.position = Vector3(
		__bobLateral,
		__eyeCurrent + __bobVertical + breathLift + __springPos,
		0
	)

	Head.rotation = Vector3(
		__smoothPitch + breathPitch + deg_to_rad(__landPitch),
		0,
		clampf(strafeRoll + errRoll + bobRoll, -deg_to_rad(5), deg_to_rad(5))
	)

	var fovTarget = BaseFOV + __sprintMix * SprintFOVBoost - clampf(__springVel, -3, 3) * 1.2
	__camera.fov = lerpf(__camera.fov, fovTarget, __exp_weight__(FOVSmoothing, Delta))

	Health = clampf(Health, 0, 100)

	if (Health <= 0):
		Die()

func _physics_process(Delta: float) -> void:
	var inputDir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")

	if (is_on_floor()):
		FallTime = 0
		__coyote = CoyoteTime
	else:
		__coyote -= Delta
		velocity += get_gravity() * GravityMultiplier * (FallTime + 1) * Delta
		FallTime = clampf(FallTime + Delta, 0, clampf(GravityMultiplier, 0.001, 9999) * 9.81)

	if (Input.is_action_just_pressed("move_jump")):
		__jumpBuffer = JumpBufferTime
	else:
		__jumpBuffer -= Delta

	var wantCrouch = Input.is_action_pressed("toggle_crouch")

	if (!wantCrouch && __crouchAmount > 0.01 && !__can_stand__()):
		wantCrouch = true

	var crouchTarget = 1.0 if wantCrouch else 0.0
	__crouchAmount = lerpf(__crouchAmount, crouchTarget, __exp_weight__(CrouchBlendSpeed, Delta))

	var crouchHeight = __initHeight * CrouchHeightRatio
	var height = lerpf(__initHeight, crouchHeight, __crouchAmount)
	__collider.shape.height = height
	__collider.position.y = height * 0.5

	var moving = inputDir.length_squared() > 0.0001
	var sprintWanted = Input.is_action_pressed("move_sprint") && moving && __crouchAmount < 0.5
	__sprintMix = lerpf(__sprintMix, 1.0 if sprintWanted else 0.0, __exp_weight__(8, Delta))

	if (__crouchAmount >= 0.5):
		CurrentSpeed = CrouchSpeed
	elif (sprintWanted):
		CurrentSpeed = RunSpeed
	else:
		CurrentSpeed = WalkSpeed

	CurrentDirection = (transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized() if moving else Vector3.ZERO

	var rate = GroundAcceleration if is_on_floor() else AirAcceleration
	var w = __exp_weight__(rate, Delta)
	velocity.x = lerpf(velocity.x, CurrentDirection.x * CurrentSpeed, w)
	velocity.z = lerpf(velocity.z, CurrentDirection.z * CurrentSpeed, w)

	if (__jumpBuffer > 0 && __coyote > 0):
		velocity.y = JumpVelocity
		__coyote = 0
		__jumpBuffer = 0
		__springVel -= 0.55

	var vyBefore = velocity.y
	move_and_slide()

	if (!__wasOnFloor && is_on_floor()):
		var impact = clampf(-vyBefore / LandingRefSpeed, 0, 1.4)

		if (impact > 0.05):
			__springVel -= impact * LandDipDistance * sqrt(LandSpringStiffness) * 1.35
			__landPitch = impact * LandPitchKickDegrees

	__wasOnFloor = is_on_floor()

	var springAccel = -LandSpringStiffness * __springPos - LandSpringDamping * __springVel
	__springVel += springAccel * Delta
	__springPos += __springVel * Delta
	__springPos = clampf(__springPos, -0.5, 0.1)

	Running = sprintWanted && is_on_floor()

	var horizSpeed = Vector2(velocity.x, velocity.z).length()
	var bobWeightTarget = 1.0 if (is_on_floor() && horizSpeed > 0.4) else 0.0
	__bobWeight = lerpf(__bobWeight, bobWeightTarget, __exp_weight__(BobWeightSmoothing, Delta))

	if (is_on_floor()):
		var freq = BobFrequencyWalk * (BobFrequencySprintScale if sprintWanted else 1.0)
		__bobPhase = fmod(__bobPhase + freq * Delta, TAU * 2)

	var amp = lerpf(BobAmplitudeWalk, BobAmplitudeSprint, __sprintMix) * lerpf(1, BobCrouchMultiplier, __crouchAmount)
	__bobLateral = sin(__bobPhase) * amp * __bobWeight
	__bobVertical = (0.5 - cos(__bobPhase * 2) * 0.5) * -amp * 0.85 * __bobWeight
	__eyeCurrent = lerpf(EyeHeightStanding, EyeHeightCrouched, __crouchAmount)
