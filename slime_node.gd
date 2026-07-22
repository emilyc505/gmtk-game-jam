extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_animation(animation_name: String) -> void:
	animation_player.play(animation_name)
