extends "res://Entity/Actor.gd"

var _health = 2

var _initial_pos = position

signal dad_dead

enum dad_state {
	IDLE,
	ATTACK,
	CHASE,
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
		queue_free()

func _physics_process(delta):
	$Eyes.scale.y = -1 if _sprite.flip_h else 1
	$Attack.scale.y = -1 if _sprite.flip_h else 1
	$Hit.scale.x = -1 if _sprite.flip_h else 1
	
	match _state:
		dad_state.IDLE:
			if motion.x == 0:
				_animation_player.play("Stand")
			else:
				_animation_player.play("Walk")
			
			if $Attack.is_colliding():
				_state = dad_state.ATTACK
				continue
			
			if $Eyes.is_colliding():
				_state = dad_state.CHASE
				continue
		
		dad_state.CHASE:
			if $Attack.is_colliding():
				_state = dad_state.ATTACK
				continue
			
			var x_input = $Eyes.scale.y if $Eyes.is_colliding() else 0
			
			motion.x = clamp(x_input * delta * TARGET_FPS * ACCELERATION, -MAX_SPEED, MAX_SPEED)
			
			if x_input == 0:
				_state = dad_state.IDLE
				continue
		
		dad_state.ATTACK:
			_animation_player.play("Attack")
			motion.x = 0
	
	motion = move_and_slide(motion, Vector2.UP)

func _on_Hurt_area_entered(area):
	_health -= 1

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		_state = dad_state.IDLE;
		_animation_player.play("Stand");
