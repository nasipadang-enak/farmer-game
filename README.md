# Farmer Game with LLM

Game RPG farming top-down 2D yang dibuat dengan Godot Engine 4.5, dilengkapi dengan NPC berbasis AI menggunakan Groq dengan model llama-3.1-8b-instant.

## Fitur
- Karakter player dengan animasi gerak 4 arah
- Peta dunia dengan tilemap (rumput, jalan, batu)
- NPC dengan sistem dialog menggunakan Dialogic
- NPC berbasis AI yang bisa diajak ngobrol secara dinamis menggunakan Google Gemini
- Pohon, rumah, dan properti sebagai dekorasi dunia

## Teknologi
- Godot Engine 4.5
- GDScript
- Dialogic v2 (plugin dialog)
- Google Gemini API

## Cara Menjalankan
1. Clone repo ini
2. Buka Godot Engine 4.5
3. Import project dari folder hasil clone
4. Isi API key Gemini di script `Script/npc.gd`
5. Jalankan scene `node_2d.tscn`

## Kontrol
- WASD / Arrow Keys — gerak karakter
- E — interact dengan NPC

## Author
nasipadang-enak
