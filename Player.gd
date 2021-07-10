extends "res://Actor.gd"

onready var sprite = $Sprite

onready var animplayer = $AnimationPlayer

var sprinting = false;

func _physics_process(delta):
	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	
	sprinting = Input.is_action_pressed("sprint");
	
	if x_input != 0:
		sprite.flip_h = x_input < 0
		if sprinting:
			animplayer.play("Run")
			motion.x += x_input * ACCELERATION * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		else:
			animplayer.play("Walk")
			motion.x += x_input * (ACCELERATION/2) * delta * TARGET_FPS
			motion.x = clamp(motion.x, -MAX_SPEED/2, MAX_SPEED/2);
	else:
		animplayer.play("Stand");
	
	motion.y += GRAVITY * delta * TARGET_FPS
	
	if is_on_floor():
		if x_input == 0:
			motion.x = lerp(motion.x, 0, FRICTION * delta)
	
	motion = move_and_slide(motion, Vector2.UP)
