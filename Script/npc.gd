extends StaticBody2D

var player_near = false
@onready var http_request = $HTTPRequest

func _ready():
	# Hubungkan sinyal jika belum
	if not http_request.request_completed.is_connected(_on_request_completed):
		http_request.request_completed.connect(_on_request_completed)

func _process(_delta):
	# Jika dekat dan tekan E, langsung minta jawaban AI
	if player_near and Input.is_action_just_pressed("interact"):
		if Dialogic.current_timeline == null:
			start_ai_request()

func start_ai_request():
	print("Menghubungi Pak Tani...")
	var message = "gimana cara gw berantas hama?" # Pertanyaan otomatis
	var url = "http://127.0.0.1:5000/chat"
	var headers = ["Content-Type: application/json"]
	var body = JSON.stringify({"message": message})
	
	http_request.request(url, headers, HTTPClient.METHOD_POST, body)

func _on_request_completed(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.parse_string(body.get_string_from_utf8())
		# Simpan jawaban AI ke variabel Dialogic
		Dialogic.VAR.jawaban_ai = json["reply"]
		start_dialog()
	else:
		print("Server error atau mati. Kode: ", response_code)

func start_dialog():
	print("Memulai visual dialog...")
	var style = load("res://style_dialog/text_buble_dialog_style.tres")
	
	# Simpan hasil start ke dalam variabel 'layout'
	var layout = Dialogic.start("d_timeline", style)
	
	# Daftarkan karakter ke node NPC ini ($Sprite2D) agar bubble-nya menempel
	# Ini akan menghilangkan instruksi kotak hitam di bawah
	var npc_resource = load("res://d_character/npc_petani.dch")
	layout.register_character(npc_resource, $Sprite2D)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_near = true
		print(body.name , " masuk")

func _on_area_2d_body_exited(body):	
	if body.name == "Player":
		player_near = false
		print(body.name , " keluar")
