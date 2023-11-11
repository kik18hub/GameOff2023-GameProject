extends Node

var current_scene = "world"
var transition_scene = false

var player_exit_scene_posx = 0
var player_exit_scene_posy = 0
var player_start_scene_posx = 0
var player_start_scene_posy = 0

func finish_change_scene():
	if transition_scene == true:
		transition_scene = false
		if current_scene == "world":
			current_scene = "world2"
		else:
			current_scene = "world"
