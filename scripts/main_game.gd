extends Node2D

@onready var boo = get_node("/root/Game/boo")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	boo.health
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_boo_health_changed(new_health: Variant, max_health: Variant) -> void:
	print(new_health)
	if (new_health <= 0):
		get_node("game over").show()
		boo.die();
