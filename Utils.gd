extends Node

export(String) onready var current_room setget set_current_room

func instance_scene_on_main(scene, position):
	var main = get_tree().current_scene;
	var instance = scene.instance();
	main.add_child(instance);
	instance.global_position = position;
	return instance;

func instance_control_on_main(scene, position):
	var main = get_tree().current_scene;
	var instance = scene.instance();
	main.add_child(instance);
	instance.rect_global_position = position;
	return instance;

func get_group_count(group : String):
	return get_tree().get_nodes_in_group(group).size();

func set_current_room(path):
	current_room = path;
