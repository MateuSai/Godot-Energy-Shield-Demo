extends KinematicBody2D

var projectile_scene: PackedScene = preload("res://Enemy/Projectile/EnemyProjectile.tscn")

onready var leftCanon: Position2D = get_node("Canons/LeftCanon")
onready var rightCanon: Position2D = get_node("Canons/RightCanon")

func _on_Timer_timeout() -> void:
	_spawn_projectile(leftCanon.global_position)
	_spawn_projectile(rightCanon.global_position)
	
	
func _spawn_projectile(pos: Vector2) -> void:
	var projectile: Area2D = projectile_scene.instance()
	projectile.position = pos
	get_parent().add_child(projectile)
