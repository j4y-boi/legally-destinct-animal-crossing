extends Node3D
var is_up = true
var is_up2 = true
@onready var gate_closer: Timer = $gateCloser1
@onready var gate_closer2: Timer = $gateCloser2
@onready var anim1: AnimationPlayer = $control1
@onready var anim2: AnimationPlayer = $control2

func raise(gate: int = 0):
	if gate == 0:
		anim1.play("up1")
		anim2.play("up2")
		is_up = true
		is_up2 = true
	elif gate == 1:
		anim1.play("up1")
		is_up = true
	elif gate == 2:
		anim2.play("up2")
		is_up2 = true
	else:
		print('gate doesnt exist')
		
	gate_closer.stop()
	gate_closer2.stop()

func lower(gate: int = 0):
	if gate == 0:
		anim1.play("down1")
		anim2.play("down2")
		gate_closer.start()
		gate_closer2.start()
	elif gate == 1:
		anim1.play("down1")
		gate_closer.start()
	elif gate == 2:
		anim2.play("down2")
		gate_closer2.start()
	else:
		print('gate doesnt exist')
	
func _on_gate_closer_1_timeout() -> void:
	raise(1)
func _on_gate_closer_2_timeout() -> void:
	raise(2)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "down1":
		is_up = false
	if anim_name == "down2":
		is_up2 = false
