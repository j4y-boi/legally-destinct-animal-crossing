extends VBoxContainer

var time_in_scene: float = 0.0
@onready var head: Control = $"../../.."

func format_time(seconds: float) -> String:
	var second = int(seconds)
	var hours = int(second / 3600)
	var minutes = int((second % 3600) / 60)
	var secs = int(second % 60)
	return "%02d:%02d:%02d" % [hours, minutes, secs]

func _process(delta: float) -> void:
	time_in_scene += delta
	var score = head.score
	var accidents = head.accidents
	var passed = head.carpassed
	var accuracy = 0.0
	
	$time.text = "Time on the clock : " + format_time(time_in_scene)
	$amount.text = "Animals successfully let through: " + str(score)
	$accidents.text = "Accidents: " + str(accidents)
	$cars.text = "Cars passed: " + str(passed)
	if score + accidents > 0:
		accuracy = score / (score + accidents) * 100
	else:
		accuracy = 0
	$score.text = "Overal efficiency:" + str(accuracy) + "%"
