extends "res://Scripts/UI/MenuOverlay.gd"


func _ready() -> void:
	super._ready()
	add_page_title("CREDITS", 30)

	_body_box.add_child(_para("A horror game inspired by the Backrooms.", 16, Color(0.85, 0.82, 0.78)))
	_body_box.add_child(_para("Original project, world generation and assets by the repository authors.", 14, Color(0.7, 0.66, 0.6)))
	_body_box.add_child(_para("Single-player horror, reworked bodycam camera, code-built menus, integrated scene loader.", 14, Color(0.7, 0.66, 0.6)))
	_body_box.add_child(_sep())
	_body_box.add_child(_para("Thank you for playing.", 16, Color(0.85, 0.2, 0.2)))

	add_back_button_row()


func _sep() -> ColorRect:
	var c := ColorRect.new()
	c.custom_minimum_size = Vector2(0, 1)
	c.color = Color(0.5, 0.08, 0.08, 0.6)
	return c


func _para(text: String, size: int, color: Color) -> Label:
	var l := Label.new()
	l.text = text
	l.autowrap_mode = TextServer.AUTOWRAP_WORD
	l.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	l.size_flags_vertical = Control.SIZE_SHRINK_CENTER
	l.add_theme_font_size_override("font_size", size)
	l.add_theme_color_override("font_color", color)
	return l
