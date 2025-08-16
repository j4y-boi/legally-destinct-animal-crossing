extends AnimatedSprite3D

@onready var animal: AnimatedSprite3D = $"."
@onready var smok: GPUParticles3D = $smok
@onready var exit: Area3D = $"../../exit"
@onready var entrance: Area3D = $"../../entrance"
@onready var variables: Node = $"../../Variables"
@onready var barrier: Node3D = $"../../barrier"
@onready var car_hitbox: Area3D = $"../../car1/carHitbox"
@onready var car_hitbox2: Area3D = $"../../car2/carHitbox"

var rng = RandomNumberGenerator.new()
var startPos = Vector3(-69.50,3.166,0)
var baseSpeed = 10
const animals = [
	"bear",
	"deer",
]

const offsets = [
	2,
	3.166,
]

var currentAnimal : String
var stop = false
var moving = false
var target_position: Vector3
var speed = baseSpeed
var walkingStage = 0

var basey:int
var gateopen = true
var hit = false

func randint(minimu:int, maximu:int) -> int:
	return rng.randi_range(minimu, maximu)

func glide_to(position: Vector3):
	target_position = position
	moving = true
	walkingStage += 1
	
func wait(minimu:int,maximu:int = -1):
	if maximu == -1:
		await get_tree().create_timer(minimu).timeout
	else:
		await get_tree().create_timer(randint(minimu,maximu)).timeout

func respawn():
	stop = true
	var pos = startPos
	hit = false
	speed = baseSpeed + randint(0,5)
	pos.z = rng.randi_range(-34,41)
	animal.position = pos
	var index = randint(0,len(animals)-1)
	walkingStage = 0
	
	currentAnimal = animals[index]
	basey = offsets[index]
	animal.position.y = offsets[index]
	wait(0,5)
	stop = false
	var dest = entrance.position
	dest.y += basey
	dest.z += 2
	dest.x -= 2
	glide_to(dest)

func delayRespawn(delay:int):
	wait(delay)
	respawn()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stop = true
	basey = animal.position.y
	wait(1,5)
	respawn()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	animal.visible = not stop
	smok.position = animal.position
	gateopen = not barrier.is_up
	
	if not stop:
		var distance2 = car_hitbox2.global_transform.origin.distance_to(animal.global_transform.origin)
		var distance1 = car_hitbox.global_transform.origin.distance_to(animal.global_transform.origin)
		var t = 15
		print(str(distance1)+" | "+ str(distance2))
		
		if (distance1 <= t or distance2 <= t) and not hit:
			hit = true
			die()
		if moving:
			animal.animation = "walk_" + currentAnimal
			var direction = target_position - global_transform.origin
			var distance = direction.length()
			
			if distance <= 1:
				global_transform.origin = target_position
				moving = false
			else:
				var move = direction.normalized() * speed * delta
				move.y = 0  # uhhhhhhhhhhhhhh
				global_transform.origin += move
				global_transform.origin.y = basey  # animal ehight
		else:
			if walkingStage == 1 and gateopen:
				var dest = exit.position
				dest.y += basey
				dest.z += 2
				dest.x -= 2
				glide_to(dest)
			elif walkingStage == 2 and gateopen:
				variables.score += 1
				var dest = Vector3(68,0,randint(-33,39))
				dest.y += basey
				glide_to(dest)
			elif walkingStage == 3:
				delayRespawn(randint(0,4))
			animal.animation = "idle_" + currentAnimal

func die():
	#smok.emitting = true
	variables.accidents += 1
	#await wait(1)
	animal.visible = false
	#smok.emitting = false
	await wait(1)
	respawn()
