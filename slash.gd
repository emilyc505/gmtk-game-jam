extends Area2D

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("light_slash")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
