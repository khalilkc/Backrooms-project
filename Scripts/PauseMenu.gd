extends CanvasLayer

var _overlay: ColorRect
var _container: Control
var _buttons: Array[Button] = []
var _is_paused: bool = false


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 10
	_build_ui()
	visible = false


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("ui_cancel")):
		if (_is_paused):
			_resume()
		else:
			_open()


func _open() -> void:
	_is_paused = true
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	_animate_open()


func _resume() -> void:
	_is_paused = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	_animate_close()


func _animate_open() -> void:
	_overlay.modulate.a = 0.0
	_container.modulate.a = 0.0
	_container.position.y = 10.0
	for b in _buttons:
		b.modulate.a = 0.0
		b.position.x = -20.0

	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(_overlay, "modulate:a", 1.0, 0.2)

	var t2 := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t2.tween_interval(0.05)
	t2.tween_property(_container, "modulate:a", 1.0, 0.25)
	t2.parallel().tween_property(_container, "position:y", 0.0, 0.3).set_trans(Tween.TRANS_BACK)

	for i in _buttons.size():
		var b := _buttons[i]
		var bt := create_tween().set_parallel(true)
		bt.tween_interval(0.1 + 0.04 * i)
		bt.tween_property(b, "modulate:a", 1.0, 0.3).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		bt.tween_property(b, "position:x", 0.0, 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _animate_close() -> void:
	var t := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(_overlay, "modulate:a", 0.0, 0.15)
	t.parallel().tween_property(_container, "modulate:a", 0.0, 0.15)
	t.tween_callback(func(): visible = false)


func _build_ui() -> void:
	_overlay = ColorRect.new()
	_overlay.set_anchors_preset(Control.PRESET_FULL_RECT)
	_overlay.mouse_filter = Control.MOUSE_FILTER_STOP
	_overlay.color = Color(0, 0, 0, 0.7)
	add_child(_overlay)

	_container = Control.new()
	_container.set_anchors_preset(Control.PRESET_FULL_RECT)
	_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_container)

	var center := VBoxContainer.new()
	center.set_anchors_preset(Control.PRESET_CENTER)
	center.grow_horizontal = Control.GROW_DIRECTION_BOTH
	center.grow_vertical = Control.GROW_DIRECTION_BOTH
	center.offset_left = -150
	center.offset_right = 150
	center.offset_top = -160
	center.offset_bottom = 160
	center.add_theme_constant_override("separation", 6)
	center.alignment = BoxContainer.ALIGNMENT_CENTER
	_container.add_child(center)

	var title := Label.new()
	title.text = "PAUSED"
	title.add_theme_font_size_override("font_size", 13)
	title.add_theme_color_override("font_color", Color(0.7, 0.12, 0.12))
	title.add_theme_constant_override("outline_size", 4)
	title.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	title.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	center.add_child(title)

	_add_button(center, "RESUME", _on_resume)
	_add_button(center, "RESTART", _on_restart)
	_add_disabled_button(center, "SETTINGS")
	_add_button(center, "MAIN MENU", _on_main_menu)
	_add_button(center, "QUIT", _on_quit)


func _add_button(parent: Control, text: String, callback: Callable) -> Button:
	var b := _create_button(text)
	b.pressed.connect(callback)
	b.mouse_entered.connect(_on_hover.bind(b))
	b.mouse_exited.connect(_on_unhover.bind(b))
	parent.add_child(b)
	_buttons.append(b)
	return b


func _add_disabled_button(parent: Control, text: String) -> void:
	var b := _create_button(text)
	b.disabled = true
	parent.add_child(b)
	_buttons.append(b)


func _create_button(text: String) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(280, 44)
	b.focus_mode = Control.FOCUS_NONE
	b.alignment = HORIZONTAL_ALIGNMENT_LEFT
	b.add_theme_constant_override("outline_size", 3)
	b.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.9))
	b.add_theme_font_size_override("font_size", 18)

	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.02, 0.01, 0.01, 0.55)
	normal.border_width_left = 3
	normal.border_color = Color(0.5, 0.08, 0.08, 0.0)
	normal.content_margin_left = 14
	normal.corner_radius_top_left = 2
	normal.corner_radius_bottom_left = 2
	var hover := normal.duplicate()
	hover.bg_color = Color(0.12, 0.02, 0.02, 0.85)
	hover.border_color = Color(0.85, 0.15, 0.15, 1.0)
	var pressed := hover.duplicate()
	pressed.bg_color = Color(0.22, 0.04, 0.04, 0.95)
	b.add_theme_stylebox_override("normal", normal)
	b.add_theme_stylebox_override("hover", hover)
	b.add_theme_stylebox_override("pressed", pressed)
	b.add_theme_stylebox_override("focus", normal)
	b.add_theme_stylebox_override("disabled", normal.duplicate())
	b.add_theme_color_override("font_color", Color(0.85, 0.82, 0.78))
	b.add_theme_color_override("font_hover_color", Color(1, 0.97, 0.95))
	b.add_theme_color_override("font_pressed_color", Color(1, 1, 1))
	b.add_theme_color_override("font_disabled_color", Color(0.42, 0.4, 0.38))
	b.pivot_offset = Vector2(0, 22)
	return b


func _on_hover(b: Button) -> void:
	if (b.disabled):
		return
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	t.tween_property(b, "scale", Vector2(1.05, 1.0), 0.15)
	t.parallel().tween_property(b, "position:x", 6.0, 0.15).set_trans(Tween.TRANS_CUBIC)
	for other in _buttons:
		if (other != b && !other.disabled):
			var dt := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			dt.tween_property(other, "modulate:a", 0.45, 0.15)


func _on_unhover(b: Button) -> void:
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(b, "scale", Vector2.ONE, 0.15)
	t.parallel().tween_property(b, "position:x", 0.0, 0.15)
	for other in _buttons:
		if (other != b && !other.disabled):
			var dt := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			dt.tween_property(other, "modulate:a", 1.0, 0.2)


func _on_resume() -> void:
	_resume()


func _on_restart() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SceneLoader.goto_scene(get_tree().current_scene.scene_file_path)


func _on_main_menu() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	SceneLoader.goto_scene("res://Scenes/MainMenu.tscn")


func _on_quit() -> void:
	get_tree().quit()
