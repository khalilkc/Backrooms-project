extends Control

signal back_requested

var _content_panel: PanelContainer
var _body_box: VBoxContainer


func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	mouse_filter = Control.MOUSE_FILTER_STOP
	_overlay_background(0.85)
	_build_scaffold()


func _build_scaffold() -> void:
	var margin := MarginContainer.new()
	margin.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	margin.add_theme_constant_override("margin_left", 64)
	margin.add_theme_constant_override("margin_right", 64)
	margin.add_theme_constant_override("margin_top", 32)
	margin.add_theme_constant_override("margin_bottom", 32)
	add_child(margin)

	_content_panel = PanelContainer.new()
	_content_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_content_panel.size_flags_vertical = Control.SIZE_EXPAND_FILL
	_content_panel.add_theme_stylebox_override("panel", _make_panel_style())
	margin.add_child(_content_panel)

	_body_box = VBoxContainer.new()
	_body_box.add_theme_constant_override("separation", 12)
	_content_panel.add_child(_body_box)


func add_page_title(text: String, size: int = 34) -> Label:
	var l := _title(text, size)
	l.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_body_box.add_child(l)
	var sep := _separator()
	_body_box.add_child(sep)
	return l


func add_back_button_row() -> void:
	var h := HBoxContainer.new()
	h.alignment = BoxContainer.ALIGNMENT_CENTER
	h.add_theme_constant_override("separation", 12)
	h.add_child(_make_back_button())
	_body_box.add_child(h)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		back_requested.emit()
		get_viewport().set_input_as_handled()


func _separator() -> ColorRect:
	var c := ColorRect.new()
	c.custom_minimum_size = Vector2(0, 1)
	c.color = Color(0.5, 0.08, 0.08, 0.6)
	return c


func _make_back_button() -> Button:
	var b := Button.new()
	b.text = "BACK"
	b.custom_minimum_size = Vector2(160, 44)
	b.focus_mode = Control.FOCUS_NONE
	_style_button(b)
	b.pressed.connect(back_requested.emit)
	return b


func _style_button(b: Button, accent: bool = false) -> void:
	var normal := StyleBoxFlat.new()
	normal.bg_color = Color(0.05, 0.02, 0.02, 0.92)
	normal.border_width_left = 2
	normal.border_width_right = 2
	normal.border_width_top = 2
	normal.border_width_bottom = 2
	normal.border_color = Color(0.6, 0.08, 0.08, 0.9) if accent else Color(0.4, 0.06, 0.06, 0.7)
	normal.corner_radius_top_left = 4
	normal.corner_radius_top_right = 4
	normal.corner_radius_bottom_left = 4
	normal.corner_radius_bottom_right = 4
	normal.content_margin_left = 14
	normal.content_margin_right = 14
	var hover := normal.duplicate()
	hover.bg_color = Color(0.18, 0.04, 0.04, 0.96)
	hover.border_color = Color(0.9, 0.2, 0.2, 1.0)
	var pressed := hover.duplicate()
	pressed.bg_color = Color(0.28, 0.06, 0.06, 1.0)
	b.add_theme_stylebox_override("normal", normal)
	b.add_theme_stylebox_override("hover", hover)
	b.add_theme_stylebox_override("pressed", pressed)
	b.add_theme_stylebox_override("focus", normal)
	b.add_theme_font_size_override("font_size", 16)
	b.add_theme_color_override("font_color", Color(0.88, 0.84, 0.8))
	b.add_theme_color_override("font_hover_color", Color(1, 0.96, 0.94))


func _make_panel_style() -> StyleBoxFlat:
	var s := StyleBoxFlat.new()
	s.bg_color = Color(0.02, 0.01, 0.01, 0.92)
	for i in 4:
		s.set_border_width(i as Side, 1)
	s.border_color = Color(0.5, 0.07, 0.07, 0.6)
	s.corner_radius_top_left = 8
	s.corner_radius_top_right = 8
	s.corner_radius_bottom_left = 8
	s.corner_radius_bottom_right = 8
	s.content_margin_left = 28
	s.content_margin_right = 28
	s.content_margin_top = 24
	s.content_margin_bottom = 24
	return s


func _overlay_background(dim_alpha: float = 0.75) -> void:
	var dim := ColorRect.new()
	dim.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	dim.color = Color(0, 0, 0, dim_alpha)
	dim.mouse_filter = Control.MOUSE_FILTER_STOP
	add_child(dim)


func _title(text: String, size: int = 34) -> Label:
	var l := Label.new()
	l.text = text
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", Color(0.85, 0.15, 0.15))
	l.add_theme_constant_override("outline_size", 6)
	l.add_theme_color_override("font_outline_color", Color(0, 0, 0, 0.9))
	return l
