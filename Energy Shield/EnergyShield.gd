extends Area2D

export(int) var max_sp: int = 5
signal max_sp_changed(new_max)
var sp: int = max_sp setget set_sp
signal sp_changed(new_value)

var recovering: bool = false
export(float) var recovering_speed: float = 1.5
signal recovering_speed_changed(new_speed)

onready var sprite: Sprite = get_node("Sprite")
onready var collisionShape: CollisionShape2D = get_node("CollisionShape2D")
onready var animationPlayer: AnimationPlayer = get_node("AnimationPlayer")
onready var recoverTimer: Timer = get_node("RecoverTimer")

func _ready() -> void:
	collisionShape.disabled = false
	sprite.self_modulate = Color(1, 1, 1, 0)
	sprite.scale = Vector2(1, 1)
	
	get_parent().connect("receive_damage", self, "_on_parent_receive_damage")
	
	emit_signal("max_sp_changed", max_sp)
	emit_signal("recovering_speed_changed", recovering_speed)
	
	
func take_damage(dam: int) -> void:
	recovering = false
	self.sp -= dam
	if sp == 0:
		animationPlayer.play("desactivate")
	else:
		animationPlayer.play("damage")
	recoverTimer.start()


func set_sp(new_value: int) -> void:
	sp = clamp(new_value, 0, max_sp)
	emit_signal("sp_changed", sp)


func _on_RecoverTimer_timeout() -> void:
	if sp == 0:
		animationPlayer.play("activate")
		
	recovering = true
	while recovering:
		self.sp += 1
		if sp == max_sp:
			recovering = false
		yield(get_tree().create_timer(recovering_speed), "timeout")
		
		
func _on_parent_receive_damage() -> void:
	recovering = false
	recoverTimer.start()
