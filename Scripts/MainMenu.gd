extends Control

const CreditsScript := preload("res://Scripts/UI/CreditsPanel.gd")
const HUB_PATH := "res://Scenes/Level TheHub.tscn"

var _video: VideoStreamPlayer
var _vignette: ColorRect
var _grain: ColorRect
var _dim: ColorRect

var _button_container: VBoxContainer
var _buttons: Array[Button] = []
var 	_accent_label: Label

var _active_overlay: Control = null
var _credits_panel: Control = null
var _hovered_button: Button = null


func _ready() -> void:
	get_tree().paused = false
	Globals.CheckInstance()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	set_anchors_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_STOP
	_build_background()
	_build_main_buttons()
	_animate_intro()
	_animate_ambient()


func _process(_delta: float) -> void:
	if (_video != null && _video.visible):
		var mouse_pos := get_viewport().get_mouse_position()
		var viewport_size := get_viewport().get_visible_rect().size
		var offset_x := (mouse_pos.x / viewport_size.x - 0.5) * -6.0
		var offset_y := (mouse_pos.y / viewport_size.y - 0.5) * -4.0
		_video.position = Vector2(offset_x, offset_y)


func _build_background() -> void:
	_video = VideoStreamPlayer.new()
	_video.set_anchors_preset(Control.PRESET_FULL_RECT)
	_video.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_video.expand = true
	_video.stream = load("res://Video/MainMenu.ogv")
	_video.autoplay = true
	_video.loop = true
	add_child(_video)
	_video.play()

	_vignette = ColorRect.new()
	_vignette.set_anchors_preset(Control.PRESET_FULL_RECT)
	_vignette.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_vignette.material = _make_vignette_material()
	add_child(_vignette)

	_grain = ColorRect.new()
	_grain.set_anchors_preset(Control.PRESET_FULL_RECT)
	_grain.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_grain.material = _make_grain_material()
	add_child(_grain)

	_dim = ColorRect.new()
	_dim.set_anchors_preset(Control.PRESET_FULL_RECT)
	_dim.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_dim.color = Color(0, 0, 0, 0.35)
	add_child(_dim)


func _build_main_buttons() -> void:
	_button_container = VBoxContainer.new()
	_button_container.anchor_left = 0.04
	_button_container.anchor_top = 1.0
	_button_container.anchor_right = 0.04
	_button_container.anchor_bottom = 1.0
	_button_container.offset_left = 0
	_button_container.offset_right = 320
	_button_container.offset_top = -340
	_button_container.offset_bottom = -30
	_button_container.add_theme_constant_override("separation", 6)
	add_child(_button_container)

	_accent_label = Label.new()
	_accent_label.text = "BACKROOMS"
	_accent_label.add_theme_font_size_override("font_size", 13)
	_accent_label.add_theme_color_override("font_color", Color(0.7, 0.12, 0.12))
	_accent_label.add_theme_constant_override("outline_size", 4)
	_accent_label.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.8))
	_accent_label.offset_left = 10
	_button_container.add_child(_accent_label)

	_add_button("PLAY", _on_play, true)
	_add_disabled_button("SETTINGS")
	_add_button("CREDITS", _on_credits, false)
	_add_button("EXIT", _on_exit, false)

	_button_container.add_child(_create_spacer())


func _create_spacer() -> Control:
	var s := Control.new()
	s.custom_minimum_size = Vector2(0, 8)
	return s


func _add_button(text: String, callback: Callable, is_primary: bool) -> Button:
	var b := _create_menu_button(text, is_primary)
	b.pressed.connect(callback)
	b.mouse_entered.connect(_on_button_hover.bind(b))
	b.mouse_exited.connect(_on_button_unhover.bind(b))
	_button_container.add_child(b)
	_buttons.append(b)
	return b


func _add_disabled_button(text: String) -> void:
	var b := _create_menu_button(text, false)
	b.disabled = true
	_button_container.add_child(b)
	_buttons.append(b)


func _create_menu_button(text: String, is_primary: bool) -> Button:
	var b := Button.new()
	b.text = text
	b.custom_minimum_size = Vector2(300, 46)
	b.focus_mode = Control.FOCUS_NONE
	b.alignment = HORIZONTAL_ALIGNMENT_LEFT
	b.add_theme_constant_override("outline_size", 3)
	b.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.9))
	b.add_theme_font_size_override("font_size", 20)

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
	b.pivot_offset = Vector2(0, 23)

	if (is_primary):
		_animate_play_glow(b)

	return b


func _on_button_hover(b: Button) -> void:
	if (b.disabled):
		return
	_hovered_button = b
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	t.tween_property(b, "scale", Vector2(1.06, 1.0), 0.18)
	t.parallel().tween_property(b, "position:x", 8.0, 0.18).set_trans(Tween.TRANS_CUBIC)
	for other in _buttons:
		if (other != b && !other.disabled && other.is_visible_in_tree()):
			var dim_t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			dim_t.tween_property(other, "modulate:a", 0.45, 0.2)


func _on_button_unhover(b: Button) -> void:
	_hovered_button = null
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	t.tween_property(b, "scale", Vector2.ONE, 0.2)
	t.parallel().tween_property(b, "position:x", 0.0, 0.2)
	for other in _buttons:
		if (other != b && !other.disabled && other.is_visible_in_tree()):
			var bright_t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			bright_t.tween_property(other, "modulate:a", 1.0, 0.25)


func _animate_play_glow(b: Button) -> void:
	var glow := create_tween().set_loops()
	glow.tween_interval(2.0)
	glow.tween_property(b, "modulate", Color(1.0, 0.92, 0.88, 1.0), 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	glow.tween_property(b, "modulate", Color(1.0, 1.0, 1.0, 1.0), 1.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _animate_intro() -> void:
	_accent_label.modulate.a = 0.0
	_accent_label.position.y = -20
	var accent_t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	accent_t.tween_property(_accent_label, "modulate:a", 1.0, 0.6)
	accent_t.parallel().tween_property(_accent_label, "position:y", 0.0, 0.6)

	for i in _buttons.size():
		var b := _buttons[i]
		b.modulate.a = 0.0
		b.position.x = -40
		b.scale = Vector2(0.95, 1.0)
		var t := create_tween().set_parallel(true)
		t.tween_interval(0.12 + 0.07 * i)
		t.tween_property(b, "modulate:a", 1.0, 0.45).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		t.tween_property(b, "position:x", 0.0, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		t.tween_property(b, "scale", Vector2.ONE, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


func _animate_ambient() -> void:
	var breath := create_tween().set_loops()
	breath.tween_property(_vignette, "modulate:a", 0.75, 2.8).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	breath.tween_property(_vignette, "modulate:a", 1.0, 4.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	var grain_pulse := create_tween().set_loops()
	grain_pulse.tween_property(_grain, "modulate:a", 1.3, 5.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	grain_pulse.tween_property(_grain, "modulate:a", 1.0, 5.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)

	var accent_t := create_tween().set_loops()
	accent_t.tween_property(_accent_label, "modulate:a", 0.45, 1.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	accent_t.tween_property(_accent_label, "modulate:a", 1.0, 1.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)


func _show_overlay(overlay: Control) -> void:
	if (_active_overlay != null && is_instance_valid(_active_overlay)):
		_active_overlay.queue_free()
	_active_overlay = overlay

	var hide_t := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	hide_t.tween_property(_button_container, "modulate:a", 0.0, 0.15)
	hide_t.tween_callback(func(): _button_container.visible = false)

	add_child(overlay)
	overlay.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	overlay.modulate.a = 0.0
	overlay.position.y = 15.0
	var t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	t.tween_interval(0.1)
	t.tween_property(overlay, "modulate:a", 1.0, 0.3)
	t.parallel().tween_property(overlay, "position:y", 0.0, 0.35).set_trans(Tween.TRANS_CUBIC)
	overlay.back_requested.connect(_close_overlay)


func _close_overlay() -> void:
	if (_active_overlay != null && is_instance_valid(_active_overlay)):
		var t := create_tween().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
		t.tween_property(_active_overlay, "modulate:a", 0.0, 0.2)
		t.parallel().tween_property(_active_overlay, "position:y", -10.0, 0.2)
		t.tween_callback(_active_overlay.queue_free)
	_active_overlay = null

	_button_container.visible = true
	_button_container.modulate.a = 0.0
	for b in _buttons:
		b.modulate.a = 1.0
		b.position.x = 0
		b.scale = Vector2.ONE
	var show_t := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	show_t.tween_property(_button_container, "modulate:a", 1.0, 0.25)


func _on_play() -> void:
	var flash := ColorRect.new()
	flash.set_anchors_preset(Control.PRESET_FULL_RECT)
	flash.color = Color(1, 1, 1, 0.0)
	flash.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(flash)
	var t := create_tween()
	t.tween_property(flash, "color:a", 0.15, 0.1).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	t.tween_property(flash, "color:a", 0.0, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	t.tween_callback(flash.queue_free)
	SceneLoader.goto_scene(HUB_PATH)


func _on_credits() -> void:
	if (_credits_panel == null):
		_credits_panel = CreditsScript.new()
	_show_overlay(_credits_panel)
	_credits_panel = null


func _on_exit() -> void:
	var t := create_tween()
	t.tween_property(_dim, "color:a", 1.0, 0.5).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	t.tween_property(_video, "volume_db", -40.0, 0.4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
	t.tween_callback(get_tree().quit)


func _make_vignette_material() -> ShaderMaterial:
	var sh := Shader.new()
	sh.code = """
shader_type canvas_item;
uniform float vignette_intensity : hint_range(0.0, 3.0) = 1.25;
uniform float vignette_opacity : hint_range(0.0, 1.0) = 0.85;
uniform vec4 tint_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
void fragment() {
	vec2 uv = UV - 0.5;
	float vig = 1.0 - dot(uv, uv) * vignette_intensity;
	vig = clamp(vig, 0.0, 1.0);
	COLOR = tint_color;
	COLOR.a = mix(vignette_opacity, 0.0, vig);
}
"""
	var m := ShaderMaterial.new()
	m.shader = sh
	return m


func _make_grain_material() -> ShaderMaterial:
	var sh := Shader.new()
	sh.code = """
shader_type canvas_item;
uniform float amount : hint_range(0.0, 0.25) = 0.05;
float rand(vec2 co){ return fract(sin(dot(co, vec2(12.9898,78.233))) * 43758.5453); }
void fragment() {
	float n = rand(UV + vec2(TIME * 0.4, 0.0));
	COLOR = vec4(n, n, n, (n - 0.5) * amount);
}
"""
	var m := ShaderMaterial.new()
	m.shader = sh
	return m
