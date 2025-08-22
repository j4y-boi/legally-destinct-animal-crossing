extends Control

@onready var cam1: SubViewport = $HBoxContainer/camcontainer1/cam1
@onready var camcontainer_1: SubViewportContainer = $HBoxContainer/camcontainer1
@onready var fg: ColorRect = $ColorRect2
@onready var window: MarginContainer = $HBoxContainer/MarginContainer
@onready var bg: ColorRect = $ColorRect

var currentCam = 1
var game_scene = preload("res://scenes/game.tscn")
var scene1 = game_scene.instantiate()
const debug = false

#keepin it for that stats
var score = 0
var accidents = 0
var carpassed

func _ready():
	cam1.add_child(scene1)
	scene1.get_node("lantern/Camera3D2").current = true
	
	if debug:
		bg.visible = false
		window.visible = true
		camcontainer_1.visible = false

func _process(_delta: float) -> void:
	score = scene1.get_node("Variables").score
	accidents = scene1.get_node("Variables").accidents
	carpassed = scene1.get_node("Variables").carpassed

func _on_switch_pressed() -> void:
	if not debug:
		if currentCam == 1:
			currentCam = 2
			scene1.get_node("lantern2/Camera3D").current = true
		else:
			currentCam = 1
			scene1.get_node("lantern/Camera3D2").current = true
	else:
		print("use freecam hobo")

func _on_close_pressed() -> void:
	var is_up = scene1.get_node("barrier").is_up
	var control1 = scene1.get_node("barrier/control1")
	var control2 = scene1.get_node("barrier/control2")
	if not control1.current_animation != "" and not control2.current_animation != "":
		if is_up:
			scene1.get_node("barrier").lower(0)
		else:
			scene1.get_node("barrier").raise(0)

func _on_toggle_1_pressed() -> void:
	var is_up = scene1.get_node("barrier").is_up
	var animationPlayer = scene1.get_node("barrier/control1")
	if not animationPlayer.current_animation != "":
		if is_up:
			scene1.get_node("barrier").lower(1)
		else:
			scene1.get_node("barrier").raise(1)

func _on_toggle_2_pressed() -> void:
	var is_up2 = scene1.get_node("barrier").is_up2
	var animationPlayer = scene1.get_node("barrier/control2")
	if not animationPlayer.current_animation != "":
		if is_up2:
			scene1.get_node("barrier").lower(2)
		else:
			scene1.get_node("barrier").raise(2)

func _on_exit_pressed() -> void:
	fg.modulate.a = 0.0
	fg.visible = true
	$leave.play()
	var tween = self.create_tween()
	tween.tween_property(fg, "modulate:a", 1.0, 1)
	tween.tween_interval(.5)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
