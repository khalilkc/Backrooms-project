extends VoxelGI

@export var bake_interval := 2.5
@export var bake_distance := 4.0

var _timer := 0.0
var _last_pos := Vector3.INF
var _bakes := 0

func _process(delta: float) -> void:
	if DisplayServer.get_name() == "headless":
		return
	var cam := get_viewport().get_camera_3d()
	if cam == null:
		return
	_timer += delta
	if _timer < bake_interval:
		return
	_timer = 0.0
	var p := cam.global_position
	if _bakes < 3 or _last_pos == Vector3.INF or p.distance_to(_last_pos) >= bake_distance:
		_bakes += 1
		_last_pos = p
		bake()