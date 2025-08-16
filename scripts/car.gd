extends Node3D
@onready var car: Node3D = $"."
@onready var car_front: Sprite3D = $carHitbox/CollisionShape3D/carFront
@onready var car_back: Sprite3D = $carHitbox/CollisionShape3D/carBack
@onready var barrier: Node3D = $"../barrier"
@onready var variables: Node = $"../Variables"


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
var counter = 0

var rng = RandomNumberGenerator.new()

func randint(minimu:int, maximu:int) -> int: #im used to python :P
	return rng.randi_range(minimu, maximu)

func newPos():
	current = 1 - current
	if randint(1,1) == 1:
		randomOffset = randint(30,40)
	else:
		randomOffset = randint(0,4)
	car.position = startPos[current]
	car.rotation = startRot[current]
	var randomColor = Color(0,0,0)
	while randomColor == Color(0,0,0):
		randomColor = Color(rng.randi_range(0,1), rng.randi_range(0,1), rng.randi_range(0,1))
	
	var mat = car_front.material_override # I HATE SHADERS WHO THE FUCK NEEDS THEM ANYWAY
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("lowColor", Color(0,0,0))
		mat.set_shader_parameter("midColor", randomColor)
		mat.set_shader_parameter("highColor", Color(1,1,1))

	mat = car_back.material_override
	if mat and mat is ShaderMaterial:
		mat.set_shader_parameter("lowColor", Color(0,0,0))
		mat.set_shader_parameter("midColor", randomColor)
		mat.set_shader_parameter("highColor", Color(1,1,1))

	await get_tree().create_timer(randint(1,5)).timeout
	stop = false

func respawn():
	counter = 0
	stop = true
	newPos()

func _process(delta: float) -> void:
	var gateOpen = not barrier.is_up
	if not stop:
		counter += 1
		if gateOpen:
			car.translate(Vector3(0,0,(SPEED/2) * delta))
		else:
			car.translate(Vector3(0,0,(SPEED + randomOffset) * delta))
		# in case we miss hitbox
		var target_z = startPos[1 - current].z
		if (current == 0 and car.global_transform.origin.z >= target_z) or (current == 1 and car.global_transform.origin.z <= target_z):
			variables.carpassed += 1
			respawn()
		if counter >= 6000: #in case the in case we miss hitbox fails
			variables.carpassed += 1
			respawn()

func _on_tunnel_1_area_entered(_area: Area3D) -> void:
	if current == 1 and not stop:
		respawn()

func _on_tunnel_2_area_entered(_area: Area3D) -> void:
	if current == 0 and not stop:
		respawn()

func _ready() -> void:
	current = int(car.name.left(4))%2
	car.position = startPos[current]
	car.rotation = startRot[current]
	stop = true
	await get_tree().create_timer(rng.randf_range(0.00,1.00)).timeout
	respawn()
