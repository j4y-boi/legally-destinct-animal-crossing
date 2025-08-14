extends Control

@export var playScene : PackedScene
@export var fg : ColorRect
@onready var exit: Button = $Content/exit
@onready var play: Button = $Content/play
@onready var title: Label = $Content/Title

const height = 10
const speed: = 10

var starty: = 0
var timer: = 0.0 #SCREW YOU, I AINT USING THEM LIBRARIES

func _on_play_pressed() -> void:
	fg.visible = true
	$Confirm.play()
	var tween = self.create_tween()
	tween.tween_property(fg, "modulate:a", 1.0, 1)
	tween.tween_interval(.5)
	await tween.finished
	get_tree().change_scene_to_packed(playScene)

func _on_exit_pressed() -> void:
	fg.visible = true
	$Back.play()
	var tween = self.create_tween()
	tween.tween_property(fg, "modulate:a", 1.0, 0.5)
	tween.tween_interval(.5)
	await tween.finished
	get_tree().quit()

func _on_play_mouse_entered() -> void:
	$Hover.play()

func _on_exit_mouse_entered() -> void:
	$Hover.play()

func _ready() -> void:
	fg.modulate.a = 0.0
	fg.visible = false
	#if title.get_parent() is MarginContainer:
	#	starty = title.get_parent().margin_top

#func _process(delta: float):
	#timer += delta
	#if title.get_parent() is MarginContainer:
	#	title.get_parent().margin_top = starty + sin(timer * speed) * height
