extends StaticBody2D

var player_near = false
@onready var label_e = $Label

func _process(delta):
	if player_near and Input.is_action_just_pressed("interact"):
		start_dialog()

func start_dialog():
	var timeline = Dialogic.start("d_timeline")
	timeline.register_character(
		load("res://d_character/npc_petani.dch"),
		$Sprite2D
	)
	timeline.register_character(
		load("res://d_character/player.dch"),
		$"../Player/player"
	)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		print("Player masuk")
		player_near = true
		label_e.visible = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		print("Player keluar")
		player_near = false
		label_e.visible = false
		
