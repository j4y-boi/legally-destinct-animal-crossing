extends Control

@onready var cam1: SubViewport = $HBoxContainer/camcontainer1/cam1
@onready var camcontainer_1: SubViewportContainer = $HBoxContainer/camcontainer1

var currentCam = 1
var game_scene = preload("res://scenes/game.tscn")
var scene1 = game_scene.instantiate()

func _ready():
	cam1.add_child(scene1)
	scene1.get_node("lantern/Camera3D2").current = true

func _on_switch_button_up() -> void:
	if currentCam == 1:
		currentCam = 2
		scene1.get_node("lantern2/Camera3D").current = true
	else:
		currentCam = 1
		scene1.get_node("lantern/Camera3D2").current = true
