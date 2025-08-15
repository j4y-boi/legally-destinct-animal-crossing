extends Node3D
@onready var car: Node3D = $"."
@onready var car_front: Sprite3D = $carHitbox/CollisionShape3D/carFront
@onready var car_back: Sprite3D = $carHitbox/CollisionShape3D/carBack


const SPEED = 10
const dist = 80
const startPos = [
	Vector3(-12.0, 3.0, -36.3),
	Vector3(-5.4, 3.0, 42),
]
const startRot = [
	Vector3(0,0,0),
	Vector3(0,deg_to_rad(180),0),
]

var current = 0
var randomOffset = 0
var stop = false

func randint(minimu:int, maximu:int) -> int: #im used to python :P
	var rng = RandomNumberGenerator.new()
	return rng.randi_range(minimu, maximu)

func newPos():
	current = 1 - current
	randomOffset = randint(0,4)
	car.position = startPos[current]
	car.rotation = startRot[current]
	var rng = RandomNumberGenerator.new()
	var randomColor = Color(0,0,0)
	while randomColor == Color(0,0,0):
		randomColor = Color(rng.randi_range(0,1), rng.randi_range(0,1), rng.randi_range(0,1))
	
	var mat = car_front.material_override # I HATE SHADERS WHO THE FUCK NEEDS THEM ANYWAY
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("lowColor", Color(0,0,0))
		mat.set_shader_parameter("midColor", randomColor)
		mat.set_shader_parameter("highColor", Color(1,1,1))

	mat = car_back.material_override # I HATE SHADERS WHO THE FUCK NEEDS THEM ANYWAY
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("lowColor", Color(0,0,0))
		mat.set_shader_parameter("midColor", randomColor)
		mat.set_shader_parameter("highColor", Color(1,1,1))

	#car_back.modulate = randomColor
	stop = false

func respawn():
	await get_tree().create_timer(randint(1,5)).timeout
	newPos()

func _process(delta: float) -> void:
	if not stop:
		car.translate(Vector3(0,0,(SPEED + randomOffset) * delta))

func _on_tunnel_1_area_entered(_area: Area3D) -> void:
	if current == 1 and not stop:
		stop = true
		respawn()

func _on_tunnel_2_area_entered(_area: Area3D) -> void:
	if current == 0 and not stop:
		stop = true
		respawn()

func _ready() -> void:
	current = randint(0,1)
	car.position = startPos[current]
	car.rotation = startRot[current]
	stop = true
	respawn()
