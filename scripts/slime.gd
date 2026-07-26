extends CharacterBody2D

enum State {
	CHASE,
	CHARGE,
	LEAP
}


@export var move_speed := 150.0
@export var leap_speed := 700.0
@export var attack_range := 300.0
@export var charge_time := 0.4
@export var leap_time := 0.25
@onready var boo = get_node("/root/Game/boo")
@onready var slime = $"slime"
@onready var attack_area = $AttackArea

var can_attack := true
var speed = randf_range(200, 300)
@export var max_health := 4
@export var damage := 1

var health : int
var state = State.CHASE
var leap_direction := Vector2.ZERO

func _ready():
	health = max_health
	attack_area.monitoring = false

func _physics_process(_delta):
	match state:
		State.CHASE:
			if boo == null:
				velocity = Vector2.ZERO
				return
			var direction = global_position.direction_to(boo.global_position)
			velocity = direction * speed
			move_and_slide()
			if direction.x < 0:
				slime.play_animation("defaultL")
			else:
				slime.play_animation("defaultR")
			if can_attack and global_position.distance_to(boo.global_position) <= attack_range:
				start_charge()
		State.CHARGE:
			velocity = Vector2.ZERO
			move_and_slide()
		State.LEAP:
			move_and_slide()

func start_charge():
	if state != State.CHASE:
		return
	state = State.CHARGE
	velocity = Vector2.ZERO
	# Lock onto player's current position
	leap_direction = global_position.direction_to(boo.global_position)
	# TODO: charge animation
	# animation_player.play("charge")

	await get_tree().create_timer(charge_time).timeout

	if state == State.CHARGE:
		start_leap()

func start_leap():
	state = State.LEAP
	attack_area.monitoring = true
	velocity = leap_direction * leap_speed
	can_attack = false
	$AttackCD.start()
	# TODO: leap animation
	# animation_player.play("leap")

	await get_tree().create_timer(leap_time).timeout

	velocity = Vector2.ZERO
	attack_area.monitoring = false

	state = State.CHASE

func _on_attack_area_body_entered(body):
	if body == boo:
		boo.take_damage(damage)
	print("Hit:", body.name)


func _on_attack_cd_timeout() -> void:
	can_attack = true	

func take_damage(amount: int):
	health -= amount

	if health <= 0:
		die()

func die():
	queue_free()
