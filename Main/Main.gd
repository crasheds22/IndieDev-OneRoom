extends Node

func _ready():
	go_to_main_menu()

func go_to_main_menu():
	var menu = ResourceLoader.load("res://Menu/Menu.tscn")
	change_scene(menu)

func replace_Main_scene(resource):
	call_deferred("change_scene", resource)

func change_scene(resource: Resource):
	var node = resource.instance()
	
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	add_child(node)
	
	node.connect("quit", self, "go_to_main_menu")
	node.connect("replace_main)scene", self, "replace_main_scene")
