extends CharacterBody2D

@onready var boo = $"boo"
var last_direction := "right"
@export var slash: PackedScene

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

func _physics_process(delta):
	const SPEED = 600.0
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
	var slash_attack = slash.instantiate()
	# Attach to the player, not WeaponPivot
	add_child(slash_attack)
	# Get the current attack direction
	var direction = (get_global_mouse_position() - global_position).normalized()
	# Place the slash in front of the player
	slash_attack.position = direction * 128
	# Lock the rotation
	slash_attack.rotation = direction.angle()
