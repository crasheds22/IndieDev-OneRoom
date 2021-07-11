extends "res://Entity/Actor.gd"

signal player_dead

var sprinting = false;
var health = 1

enum player_state {
	IDLE,
	ATTACK,
	DEAD
}

var state = player_state.IDLE;

onready var initial_scale = scale;

func _process(delta):
	if health == 0:
		state = player_state.DEAD
		_animation_player.play("Death")
		emit_signal("player_dead")

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	match state:
		player_state.IDLE:
			sprinting = Input.is_action_pressed("sprint");
			if Input.is_action_just_pressed("attack"):
				state = player_state.ATTACK;
				_animation_player.play("Attack");
				motion.x = 0;
				return;
			
			if x_input != 0:
				_sprite.flip_h = x_input < 0
				
				if sprinting:
					_animation_player.play("Run")
					motion.x += x_input * ACCELERATION * delta * TARGET_FPS
					motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
				else:
					_animation_player.play("Walk")
					motion.x += x_input * (ACCELERATION/2) * delta * TARGET_FPS
					motion.x = clamp(motion.x, -MAX_SPEED/2, MAX_SPEED/2);
			else:
				_animation_player.play("Stand");
			
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
	
	motion = move_and_slide(motion, Vector2.UP)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Attack":
		state = player_state.IDLE;
		_animation_player.play("Stand");


func _on_Hurt_area_entered(area):
	health =- 1
