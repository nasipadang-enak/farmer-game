extends CharacterBody2D

@export var speed_jalan = 150.0

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var input_overlay = $InputOverlay


var arah_jalan
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	input_overlay.position = Vector2(0, 24)
func _physics_process(delta: float) -> void:
	pass
	arah_jalan = Input.get_vector("jalan_kiri", "jalan_kanan", "jalan_atas", "jalan_bawah")
	
	velocity = arah_jalan * speed_jalan
	
	move_and_slide()
	pilih_animasi()
	update_animation()
	


func update_animation():
	if velocity == Vector2.ZERO:
		return
	animation_tree["parameters/idle/blend_position"] = arah_jalan
	animation_tree["parameters/jalan/blend_position"] = arah_jalan
	"resource_path"
func pilih_animasi():
	if velocity == Vector2.ZERO:
		animation_tree["parameters/conditions/lagiIdle"] = true
		animation_tree["parameters/conditions/lagiJalan"] = false
	else:
		animation_tree["parameters/conditions/lagiIdle"] = false
		animation_tree["parameters/conditions/lagiJalan"] = true

func start_dialog():
	print("dialog dimulai")
	Dialogic.start("d_timeline")	
