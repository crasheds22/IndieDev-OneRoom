extends "res://Entity/Actor.gd"

var _health = 2

var _initial_pos = position

signal mum_dead

enum mum_state {
	IDLE,
	ATTACK,
	DEAD,
}

var _state = mum_state.IDLE

func _ready():
	pass;

func _process(delta: float):
	if _health == 0:
		_state = mum_state.DEAD
		_animation_player.play("Death")
		emit_signal("mum_dead")
		queue_free()

func _physics_process(delta):
	$Eyes.scale.y = -1 if _sprite.flip_h else 1
	$Attack.scale.y = -1 if _sprite.flip_h else 1
	$Hit.scale.x = -1 if _sprite.flip_h else 1
	
	match _state:
		mum_state.IDLE:
			if motion.x == 0:
				_animation_player.play("Stand")
			else:
				_animation_player.play("Walk")
			
			if $Attack.is_colliding():
				_state = mum_state.ATTACK
				_animation_player.play("Attack")
				motion.x = 0

func _on_Hurt_area_entered(area):
	_health -= 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		_state = mum_state.IDLE;
		_animation_player.play("Stand");
