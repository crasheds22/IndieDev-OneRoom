extends Control

export var text := "Your text here"

signal dead

func _ready():
	$Timer.connect("timeout", self, "die")

func _process(delta):
	$Label.set_text(text);
	
	$ColorRect.set_size($Label.get_size())

func die():
	emit_signal("dead")
	queue_free()
