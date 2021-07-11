extends KinematicBody2D

const TARGET_FPS = 60

const ACCELERATION = 8
const MAX_SPEED = 64
const FRICTION = 8
const AIR_RESISTANCE = 1
const GRAVITY = 4
const JUMP_FORCE = 128

var motion = Vector2.ZERO

onready var _sprite = $Sprite
onready var _animation_player = $AnimationPlayer

func _ready():
	pass
