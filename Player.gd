extends KinematicBody2D

signal receive_damage()

func _physics_process(_delta: float) -> void:
	var motion: Vector2 = (get_global_mouse_position() - position) * 0.2
	position += motion
	
	
func take_damage(dam: int) -> void:
	emit_signal("receive_damage")
