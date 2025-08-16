extends Node3D
var is_up = true
@onready var gate_closer: Timer = $gateCloser
@onready var anim: AnimationPlayer = $AnimationPlayer

func raise():
	anim.play("up")
	is_up = true
	gate_closer.stop()

func lower():
	anim.play("down")
	gate_closer.start()

func _on_gate_closer_timeout() -> void:
	raise()
	

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "down":
		is_up = false
