extends Control

func _ready() -> void:
	var viewport_size = get_viewport().size
	$CanvasLayer/Logo.position = Vector2(viewport_size.x/2.0, viewport_size.y/2.0)
