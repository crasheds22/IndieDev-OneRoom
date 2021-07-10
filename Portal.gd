extends Node2D

func _ready():
	$Interactible.connect("on_interact", self, "MoveToOther")

func MoveToOther(area: Area2D):
	for i in get_tree().get_nodes_in_group("Tunnel"):
		if i.get_path() != self.get_path():
			area.get_parent().global_position = i.global_position
