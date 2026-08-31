extends CanvasLayer

signal loading_started(path: String)
signal loading_finished(path: String)
signal loading_failed(path: String)


@export var fade_duration: float = 0.35
@export var min_display_time: float = 0.5
@export var loading_tips: Array[String] = [
	"Keep moving. The hum grows louder where it waits.",
	"If the lights flicker, you were never alone.",
	"The walls remember every step you take.",
	"Don't trust doors that close themselves.",
	"Almond water keeps your mind stitched together.",
]


var _is_loading: bool = false
var _target_path: String = ""
var _start_time: float = 0.0


var _background: ColorRect
var _vignette_rect: ColorRect
var _title_label: Label
var _title_base_position: Vector2 = Vector2.ZERO
var _spinner: Control
var _progress_bar: ProgressBar
var _percent_label: Label
var _tip_label: Label
var _error_label: Label


func _init() -> void:
	layer = 1000
	process_mode = Node.PROCESS_MODE_ALWAYS
	_build_ui()
	hide()


func _ready() -> void:
	hide()


class LoadingSpinner extends Control:
	var _angle: float = 0.0
	func _ready() -> void:
		visibility_changed.connect(_on_visibility_changed)
	func _process(delta: float) -> void:
		_angle += delta * 5.0
		queue_redraw()
	func _draw() -> void:
		var center: Vector2 = size / 2.0
		var radius: float = min(size.x, size.y) / 2.0 - 4.0
		draw_arc(center, radius, 0.0, TAU, 40, Color(0.15, 0.02, 0.02, 0.8), 4.0, true)
		draw_arc(center, radius, _angle, _angle + PI * 1.4, 40, Color(0.75, 0.05, 0.05, 1.0), 4.0, true)
	func _on_visibility_changed() -> void:
		set_process(is_visible_in_tree())


func _build_ui() -> void:
	_background = ColorRect.new()
	_background.set_anchors_preset(Control.PRESET_FULL_RECT)
	_background.color = Color(0.0, 0.0, 0.0, 0.0)
	_background.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(_background)
	_vignette_rect = ColorRect.new()
	_vignette_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	_vignette_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_vignette_rect.material = _create_vignette_material()
	add_child(_vignette_rect)
	var center := CenterContainer.new()
	center.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(center)
	var box := VBoxContainer.new()
	box.alignment = BoxContainer.ALIGNMENT_CENTER
	box.add_theme_constant_override("separation", 16)
	center.add_child(box)
	_title_label = Label.new()
	_title_label.text = "LOADING"
	_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title_label.add_theme_font_size_override("font_size", 30)
	_title_label.add_theme_color_override("font_color", Color(0.8, 0.1, 0.1))
	_title_label.add_theme_constant_override("outline_size", 5)
	_title_label.add_theme_color_override("font_outline_color", Color(0.0, 0.0, 0.0))
	box.add_child(_title_label)
	_spinner = LoadingSpinner.new()
	_spinner.custom_minimum_size = Vector2(56, 56)
	_spinner.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	box.add_child(_spinner)
	_progress_bar = ProgressBar.new()
	_progress_bar.custom_minimum_size = Vector2(420, 18)
	_progress_bar.min_value = 0.0
	_progress_bar.max_value = 100.0
	_progress_bar.value = 0.0
	_progress_bar.show_percentage = false
	var bg_style := StyleBoxFlat.new()
	bg_style.bg_color = Color(0.03, 0.02, 0.02, 0.95)
	bg_style.border_width_left = 1
	bg_style.border_width_right = 1
	bg_style.border_width_top = 1
	bg_style.border_width_bottom = 1
	bg_style.border_color = Color(0.45, 0.06, 0.06, 1.0)
	_progress_bar.add_theme_stylebox_override("background", bg_style)
	var fill_style := StyleBoxFlat.new()
	fill_style.bg_color = Color(0.7, 0.1, 0.1, 1.0)
	_progress_bar.add_theme_stylebox_override("fill", fill_style)
	box.add_child(_progress_bar)
	_percent_label = Label.new()
	_percent_label.text = "0%"
	_percent_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_percent_label.add_theme_font_size_override("font_size", 15)
	_percent_label.add_theme_color_override("font_color", Color(0.7, 0.68, 0.66))
	box.add_child(_percent_label)
	_tip_label = Label.new()
	_tip_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_tip_label.custom_minimum_size = Vector2(480, 0)
	_tip_label.autowrap_mode = TextServer.AUTOWRAP_WORD
	_tip_label.add_theme_font_size_override("font_size", 13)
	_tip_label.add_theme_color_override("font_color", Color(0.5, 0.48, 0.46))
	_tip_label.visible = false
	box.add_child(_tip_label)
	_error_label = Label.new()
	_error_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_error_label.add_theme_font_size_override("font_size", 16)
	_error_label.add_theme_color_override("font_color", Color(0.9, 0.2, 0.2))
	_error_label.visible = false
	box.add_child(_error_label)


func _create_vignette_material() -> ShaderMaterial:
	var shader := Shader.new()
	shader.code = """
shader_type canvas_item;
uniform float vignette_intensity : hint_range(0.0, 3.0) = 1.4;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.85;
uniform vec4 tint_color : source_color = vec4(0.1, 0.0, 0.0, 1.0);
void fragment() {
	vec2 uv = UV - 0.5;
	float vig = 1.0 - dot(uv, uv) * vignette_intensity;
	vig = clamp(vig, 0.0, 1.0);
	COLOR = tint_color;
	COLOR.a = mix(vignette_opacity, 0.0, vig);
}
"""
	var mat := ShaderMaterial.new()
	mat.shader = shader
	return mat


func is_loading() -> bool:
	return _is_loading


func set_tips(tips: Array[String]) -> void:
	loading_tips = tips


func goto_scene(path: String) -> void:
	if (_is_loading):
		return
	if (!ResourceLoader.exists(path)):
		push_error("SceneLoader: path does not exist -> " + path)
		loading_failed.emit(path)
		return
	_is_loading = true
	_target_path = path
	_start_time = Time.get_ticks_msec() / 1000.0
	_error_label.visible = false
	_progress_bar.visible = true
	_percent_label.visible = true
	_spinner.visible = true
	_progress_bar.value = 0.0
	_percent_label.text = "0%"
	_pick_random_tip()
	show()
	loading_started.emit(path)
	await _fade(0.0, 1.0)

	_progress_bar.value = 10.0
	_percent_label.text = "10%"
	await get_tree().process_frame

	var packed_scene: PackedScene = ResourceLoader.load(_target_path, "PackedScene", ResourceLoader.CACHE_MODE_REUSE)
	if (packed_scene == null):
		push_error("SceneLoader: failed to load -> " + _target_path)
		_show_error()
		return

	_progress_bar.value = 80.0
	_percent_label.text = "80%"
	await get_tree().process_frame

	var new_scene: Node = packed_scene.instantiate()
	var tree := get_tree()
	var old_scene := tree.current_scene
	tree.root.add_child(new_scene)
	tree.current_scene = new_scene
	if (old_scene != null && is_instance_valid(old_scene)):
		old_scene.queue_free()
	__activate_camera__(new_scene)

	_progress_bar.value = 100.0
	_percent_label.text = "100%"
	await get_tree().process_frame
	await get_tree().process_frame

	var elapsed: float = (Time.get_ticks_msec() / 1000.0) - _start_time
	var remaining: float = min_display_time - elapsed
	if (remaining > 0.0):
		await get_tree().create_timer(remaining).timeout

	await _fade(1.0, 0.0)
	hide()
	set_process(false)
	_title_label.modulate.a = 1.0
	_is_loading = false
	loading_finished.emit(_target_path)

func restart_current_scene() -> void:
	if (_is_loading):
		return
	var current_scene := get_tree().current_scene
	if (current_scene == null):
		return
	var current_path := current_scene.scene_file_path
	_is_loading = true
	_target_path = current_path
	_error_label.visible = false
	_tip_label.visible = false
	show()
	loading_started.emit(current_path)
	await _fade(0.0, 1.0)
	await get_tree().create_timer(min_display_time).timeout
	get_tree().reload_current_scene()
	await get_tree().process_frame
	await get_tree().process_frame
	await _fade(1.0, 0.0)
	hide()
	_title_label.modulate.a = 1.0
	_is_loading = false
	loading_finished.emit(current_path)


func _pick_random_tip() -> void:
	if (loading_tips.is_empty()):
		_tip_label.visible = false
		return
	_tip_label.text = loading_tips[randi() % loading_tips.size()]
	_tip_label.visible = true


func _process(_delta: float) -> void:
	if (!_is_loading):
		set_process(false)
		return
	if (_title_base_position == Vector2.ZERO && _title_label.position != Vector2.ZERO):
		_title_base_position = _title_label.position
	if (randf() < 0.03):
		_title_label.position = _title_base_position + Vector2(randf_range(-4.0, 4.0), randf_range(-2.0, 2.0))
		_title_label.modulate.a = randf_range(0.7, 1.0)
	else:
		_title_label.position = _title_base_position
		_title_label.modulate.a = 1.0


func _complete_scene_switch(packed_scene: PackedScene) -> void:
	var new_scene: Node = packed_scene.instantiate()
	var tree := get_tree()
	var old_scene := tree.current_scene
	tree.root.add_child(new_scene)
	tree.current_scene = new_scene
	if (old_scene != null && is_instance_valid(old_scene)):
		old_scene.queue_free()
	__activate_camera__(new_scene)
	await get_tree().process_frame
	await get_tree().process_frame
	await _fade(1.0, 0.0)
	hide()
	set_process(false)
	_title_label.modulate.a = 1.0
	_is_loading = false
	loading_finished.emit(_target_path)


func __activate_camera__(Parent: Node) -> void:
	var cameras := Parent.find_children("*", "Camera3D", true, false)
	for cam in cameras:
		if (cam is Camera3D):
			cam.current = true
			return


func _show_error() -> void:
	_progress_bar.visible = false
	_percent_label.visible = false
	_spinner.visible = false
	_tip_label.visible = false
	_error_label.text = "Failed to load scene"
	_error_label.visible = true
	loading_failed.emit(_target_path)
	await get_tree().create_timer(1.5).timeout
	await _fade(1.0, 0.0)
	hide()
	_is_loading = false


func _fade(from_alpha: float, to_alpha: float) -> void:
	_background.color.a = from_alpha
	var tween := create_tween()
	tween.set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	tween.tween_property(_background, "color:a", to_alpha, fade_duration)
	await tween.finished
