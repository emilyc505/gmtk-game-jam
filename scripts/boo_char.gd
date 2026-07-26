extends CharacterBody2D

@onready var boo = $"boo"
var last_direction := "right"
@export var slash: PackedScene
var is_attacking = false
var health = 10
var max_health = 10

signal health_changed(new_health, max_health)

func _process(delta):
	$WeaponPivot.look_at(get_global_mouse_position())

func _input(event):
	if event.is_action_pressed("move_left"):
		last_direction = "left"
	elif event.is_action_pressed("move_right"):
		last_direction = "right"
		
func _unhandled_input(event):
	if event.is_action_pressed("attack"):
		attack()

func _on_attack_finished():
	is_attacking = false

func _physics_process(delta):
	const SPEED = 600.0
	
	if is_attacking:
		velocity.x = 0
		velocity.y = 0
	else:
		var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		velocity = direction * SPEED

	move_and_slide()

	if last_direction == "left":
		if velocity.length() > 0.0:
			boo.play_animation("walkL")
		else:
			boo.play_animation("idleL")
	else:
		if velocity.length() > 0.0:
			boo.play_animation("walkR")
		else:
			boo.play_animation("idleR")

func attack():
	is_attacking = true
	var slash_attack = slash.instantiate()
	add_child(slash_attack)
	var direction = (get_global_mouse_position() - global_position).normalized()
	slash_attack.position = direction * 128
	slash_attack.rotation = direction.angle()
	await slash_attack.get_node("AnimationPlayer").animation_finished
	is_attacking = false

func take_damage(amount: int):
	health -= amount
	
	health_changed.emit(health, max_health)
	
func die():
	print("Game Over")
	queue_free()
	
