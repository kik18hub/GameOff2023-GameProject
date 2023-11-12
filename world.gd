extends Node2D

@onready var glob = load("res://glob.gd").new()

func _process(_delta):
	change_scene()


func _on_scene_transition_body_entered(body):
	if body.has_method("player"):
		glob.transition_scene = true


func _on_scene_transition_body_exited(body):
	if body.has_method("player"):
		glob.transition_scene = false
		
func change_scene():
	if glob.transition_scene == true:
		if glob.current_scene == "world":
			get_tree().change_scene_to_file("res://world_2.tscn")
			glob.finish_change_scene()
