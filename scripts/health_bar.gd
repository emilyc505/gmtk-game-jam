extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_boo_health_changed(new_health: int, max_health: int) -> void:
	value = float(new_health) / float(max_health) * 100
