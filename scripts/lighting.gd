extends Node3D

func _ready() -> void:
	if OS.get_name() == "Web":
		print("browser gaming")
		var lighting = load("res://scenes/webLighting.tscn").instantiate()
		add_child(lighting)  # attaches to Main (your root Node3D)
	else:
		print("windows gaming")
		var lighting = load("res://scenes/pcLighting.tscn").instantiate()
		add_child(lighting)
