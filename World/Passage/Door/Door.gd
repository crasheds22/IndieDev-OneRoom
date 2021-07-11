extends Node2D


var open = false;
onready var sprite = $Sprite;
onready var collider = $StaticBody2D/CollisionShape2D;


func _ready():
	$Interactible.connect("on_interact", self, "openClose");
	return;
	
func openClose(_area: Area2D):
	$Interactible.can_be_interacted = true;
	if open:
		sprite.frame = 0;
		open = false;
		collider.disabled = false;
	else:
		sprite.frame = 1;
		open = true;
		collider.disabled = true;
	return;
