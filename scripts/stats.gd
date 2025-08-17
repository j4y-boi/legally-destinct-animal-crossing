extends VBoxContainer

var time_in_scene: float = 0.0
@onready var head: Control = $"../../.."
var rng = RandomNumberGenerator.new()

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
	var accuracy: float = 0.0
	#var nu: String
	
	#for i in range(48):
	#	nu += str(randi_range(0,9))
	
	$time.text = "Time on the clock : " + format_time(time_in_scene)
	$amount.text = "Animals successfully let through: " + str(score)
	$accidents.text = "Accidents: " + str(accidents)
	$cars.text = "Cars passed: " + str(passed)
	if score + accidents > 0:
		accuracy = float(score+passed) / float(score + accidents + passed) * 100
	else:
		accuracy = 100.0
	$score.text = "Overal efficiency: " + str(int(accuracy)) + "%"
	#$magic.text = nu
	#var debg = str(score) + " / (" + str(score) + " + " + str(accidents) + ") * 100 = " + str(accuracy)
	#print(debg)
