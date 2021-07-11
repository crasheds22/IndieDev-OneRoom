extends "res://Entity/Actor.gd"

var _health = 2

signal dad_dead

enum dad_state {
	IDLE,
	ATTACK,
	DEAD,
}

var _state = dad_state.IDLE

func _ready():
	pass;

func _process(delta: float):
	if _health == 0:
		_state = dad_state.DEAD
		_animation_player.play("Death")
		emit_signal("dad_dead")

func _physics_process(delta):
	if motion.x == 0:
		_state = dad_state.IDLE
		_animation_player.play("Stand")

func _on_Hurt_area_entered(area):
	print(str("Hurt area entered, health: ", _health))
	_health -= 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		_state = dad_state.IDLE;
		_animation_player.play("Stand");
