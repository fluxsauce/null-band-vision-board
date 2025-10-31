extends Control

@export var slide_scenes: Array[PackedScene] = []
var current_slide_index: int = 0
var current_slide_instance: Node = null

func _ready():
	if not slide_scenes.is_empty():
		load_slide(0)

func zero_pad(number: int) -> String:
	if number >= 10:
		return str(number)
	return "0" + str(number)

func load_slide(index: int):
	# Only one scene at a time
	if current_slide_instance:
		current_slide_instance.queue_free()
	
	# Saftey on the index
	current_slide_index = wrap(index, 0, slide_scenes.size())
	current_slide_instance = slide_scenes[current_slide_index].instantiate()
	$CanvasLayer/PanelContainer/MarginContainer.add_child(current_slide_instance)
	
	# Update the label
	$CanvasLayer2/ColorRect/LabelPageCounter.text = zero_pad(current_slide_index + 1) + " of " + zero_pad(slide_scenes.size())

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("forward"):
		load_slide_forward()
	elif event.is_action_pressed("back"):
		load_slide_back()
	elif event.is_action_pressed("exit"):
		get_tree().quit()

func load_slide_back() -> void:
	load_slide(current_slide_index - 1)
	$AudioBackward.play()
	$CanvasLayer2/ButtonBack.grab_focus()

func load_slide_forward() -> void:
	load_slide(current_slide_index + 1)
	$AudioForward.play()
	$CanvasLayer2/ButtonForward.grab_focus()

func _on_button_back_pressed() -> void:
	load_slide_back()

func _on_button_forward_pressed() -> void:
	load_slide_forward()
