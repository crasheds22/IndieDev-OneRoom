extends Node2D

var clicks: = 0

var message_text = null

onready var message = preload("res://MessageBox.tscn")

func _ready():
	$Interactible.connect("on_interact", self, "some_function")

func some_function(_area: Area2D):
	if message_text == null:
		clicks += 1
		
		var box = Utils.instance_control_on_main(message, get_viewport_rect().size / 2)	
		message_text = str("You have clicked me ", clicks, " times")
		box.text = message_text
		
		box.connect("dead", self, "null_message")

func null_message():
	message_text = null


