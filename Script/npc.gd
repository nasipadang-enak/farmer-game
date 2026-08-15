extends StaticBody2D

var player_near = false
var t_input_ms = 0  # waktu saat pertanyaan mulai dikirim
@onready var http_request = $HTTPRequest
@onready var overlay  = $"../Player/InputOverlay"
@onready var ai_input = $"../Player/InputOverlay/Panel/ai_input"
@onready var interact_label = $interact_label

func _ready():
	# Hubungkan sinyal jika belum
	if not http_request.request_completed.is_connected(_on_request_completed):
		http_request.request_completed.connect(_on_request_completed)
	overlay.visible = false
	ai_input.text_submitted.connect(_on_input_submitted)

func _process(_delta):
	# Jika dekat dan tekan E, langsung minta jawaban AI
	if player_near and Input.is_action_just_pressed("interact"):
		if Dialogic.current_timeline == null:
			show_input()

func show_input():
	overlay.visible = true
	get_node("../Player").set_process(false)
	get_node("../Player").set_physics_process(false)
	ai_input.grab_focus()
	
func _on_input_submitted(message: String):
	print("Input submitted: ", message)
	overlay.visible = false
	ai_input.clear()  # ← tambah ini
	get_node("../Player").set_process(true)
	get_node("../Player").set_physics_process(true)
	start_ai_request(message)

func start_ai_request(message: String):
	print("Menghubungi Pak Tani...")
	t_input_ms = Time.get_ticks_msec()  # T_input: mulai kirim pertanyaan
	var url = "http://127.0.0.1:5000/chat"
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"message": message})
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var t_output_ms = Time.get_ticks_msec()  # T_output: jawaban selesai diterima
		var response_time_sec = (t_output_ms - t_input_ms) / 1000.0
		print("Waktu respon: ", response_time_sec, " detik")

		var json = JSON.parse_string(body.get_string_from_utf8())
		# Simpan jawaban AI ke variabel Dialogic
		Dialogic.VAR.jawaban_ai = json["reply"]
		start_dialog()
	else:
		print("Server error atau mati. Kode: ", response_code)

func start_dialog():
	print("Memulai visual dialog...")
	var style = load("res://style_dialog/text_buble_dialog_style.tres")
	var layout = Dialogic.start("d_timeline", style)
	var npc_resource = load("res://d_character/npc_petani.dch")
	layout.register_character(npc_resource, $Sprite2D)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true
		interact_label.visible = true
		print(body.name , " masuk")

func _on_area_2d_body_exited(body):	
	if body.name == "Player":
		player_near = false
		interact_label.visible = false
		print(body.name , " keluar")	
