extends Area2D

var sentarea = null

signal on_interact(area)

var can_be_interacted:= false

export var button:= "ui_accept"

func _on_Interactible_area_entered(area):
	sentarea = area
	can_be_interacted = true

func _on_Interactible_area_exited(area):
	sentarea = null
	can_be_interacted = false

func _process(delta):
	if can_be_interacted:
		if Input.is_action_just_pressed(button):
			can_be_interacted = false
			emit_signal("on_interact", sentarea)
