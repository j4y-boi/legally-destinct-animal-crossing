extends Node3D
var is_up = false

func raise():
	if not is_up:
		$AnimationPlayer.play("up")
		is_up = true

func lower():
	if is_up:
		$AnimationPlayer.play("down")
		is_up = false
