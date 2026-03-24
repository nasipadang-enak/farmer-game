extends Node2D

@export var cabai_scene: PackedScene
@export var jumlah_kolom: int = 5
@export var jumlah_baris: int = 10
@export var jarak: float = 20.0

func _ready() -> void:
	call_deferred("spawn_cabai")

func spawn_cabai():
	if cabai_scene == null:
		print("ERROR: cabai_scene belum di-assign!")
		return
	for baris in jumlah_baris:
		for kolom in jumlah_kolom:
			var cabai = cabai_scene.instantiate()
			cabai.position = Vector2(1100 + kolom * jarak, 450 + baris * jarak)
			add_child(cabai)

func _process(delta: float) -> void:
	pass
