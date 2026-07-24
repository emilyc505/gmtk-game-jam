extends Node2D

@onready var player = get_node("/root/Game/boo")

@export var enemy_scenes : Array[PackedScene] = [
	preload("res://bot.tscn")
]

var mid_x : int
var mid_y : int
var SPAWN_RANGE := 250

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize() # called so game does not generate the exact same numbers it is restarted
	mid_x = get_viewport_rect().size.x / 2
	mid_y = get_viewport_rect().size.y / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_rand_pos_offset() -> Vector2:
	var rads = randf_range(0, 2 * PI)
	
	var min_radius = sqrt(mid_x ** 2 + mid_y ** 2)
	var max_radius = min_radius + SPAWN_RANGE
	
	var random_radius = randf_range(min_radius, max_radius)
	
	return Vector2.from_angle(rads) * random_radius

func _on_timer_timeout() -> void:
	if player == null:
		return
	var enemy = enemy_scenes.pick_random().instantiate()	

	enemy.position = player.global_position + get_rand_pos_offset()

	get_parent().add_child(enemy)
	
	
