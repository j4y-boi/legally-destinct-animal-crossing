extends Control

@onready var cam1: SubViewport = $HBoxContainer/camcontainer1/cam1
@onready var cam2: SubViewport = $HBoxContainer/camcontainer2/cam2

func _ready():
	# Load the game scene
	var game_scene = preload("res://scenes/game.tscn")
	
	# Instance two copies for the two viewports
	var scene1 = game_scene.instantiate()
	var scene2 = game_scene.instantiate()
	
	cam1.add_child(scene1)
	cam2.add_child(scene2)
	
	# Enable only the relevant cameras
	scene1.get_node("lantern/Camera3D2").current = true
	scene2.get_node("lantern2/Camera3D").current = true
