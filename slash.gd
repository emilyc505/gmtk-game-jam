extends Area2D

@onready var animation_player = $AnimationPlayer
@export var damage := 2
var hit_bodies = []

func _ready():
	animation_player.play("light_slash")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if body in hit_bodies:
		return

	if body.has_method("take_damage"):
		body.take_damage(damage)
		
