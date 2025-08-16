extends Node3D
var is_up = true
@onready var gate_closer: Timer = $gateCloser

func raise():
	$AnimationPlayer.play("up")
	is_up = true
	gate_closer.stop()

func lower():
	$AnimationPlayer.play("down")
	is_up = false
	gate_closer.start()


func _on_gate_closer_timeout() -> void:
	raise()
