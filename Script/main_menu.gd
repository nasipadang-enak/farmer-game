extends Control

@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	main_buttons.visible = true
	options.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	pass # Replace with function body.
	get_tree().change_scene_to_file("res://scenes/main_node.tscn")

func _on_settings_pressed() -> void:
	pass # Replace with function body.
	print("Options button pressed")
	main_buttons.visible = false
	options.visible = true
	


func _on_exit_pressed() -> void:
	print("Exit button pressed")
	get_tree().quit()


func _on_back_options_pressed() -> void:
	pass # Replace with function body.
	_ready()
	print("Anda Kembali ke MEnu")
