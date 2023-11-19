extends Node2D

const ROOM = preload("res://scenes/room.tscn")
const ROOM_SIZE = Vector2(320, 160)

@export var floor_count := 5

@onready var panel: Panel = $CanvasLayer/Panel
@onready var mini_map: Node2D = $CanvasLayer/Panel/RoomRectContainer
@onready var mini_map_marker_2d: Marker2D = $CanvasLayer/Panel/Marker2D
@onready var room_container: Node2D = $RoomContainer
@onready var player_indicator_rect: ColorRect = $CanvasLayer/Panel/PlayerIndicator
@onready var player: CharacterBody2D = $Player


var room_count_per_floor := 3
var all_rooms: Array


func _ready() -> void:
	Events.root_entered.connect(_room_entered)
	all_rooms = RoomGeneration.generate_rooms()
	_add_room()
	player.position = Vector2(
				ROOM_SIZE.x * floor(RoomGeneration.room_count_per_floor / 2 + 1) - ROOM_SIZE.x / 2,
				ROOM_SIZE.y * (RoomGeneration.floor_count + 2) - ROOM_SIZE.y / 2)
	_draw_mini_map()
	

func _add_room():
	for f in range(RoomGeneration.floor_count + 2):
		for r in range(RoomGeneration.room_count_per_floor):
			var room = all_rooms[f][r]
			if room == null:
				continue
				
			var room_instance = ROOM.instantiate()
			if room.doors.has(RoomGeneration.DoorTypes.TOP):
				room_instance.has_up_door = true
			if room.doors.has(RoomGeneration.DoorTypes.RIGHT):
				room_instance.has_right_door = true
			if room.doors.has(RoomGeneration.DoorTypes.BOTTOM):
				room_instance.has_down_door = true
			if room.doors.has(RoomGeneration.DoorTypes.LEFT):
				room_instance.has_left_door = true
			room_container.add_child(room_instance)
			room_instance.position = Vector2(
				ROOM_SIZE.x * r,
				ROOM_SIZE.y * f)
	
	
func _draw_mini_map():
	mini_map_marker_2d.position.x = panel.size.x / 2 - RoomGeneration.room_count_per_floor / 2 * 6
	for f in range(RoomGeneration.floor_count + 2):
		for r in range(RoomGeneration.room_count_per_floor):
			var room = all_rooms[f][r]
			if room == null:
				continue
			var color_rect = ColorRect.new()
			color_rect.size = Vector2(5, 5)
			color_rect.color = Color.DARK_GRAY
			match room.type:
				RoomGeneration.RoomTypes.BATTLE:
					color_rect.color = Color.FIREBRICK
				RoomGeneration.RoomTypes.CHEST:
					color_rect.color = Color.GOLDENROD
				RoomGeneration.RoomTypes.BLOCK:
					color_rect.color = Color.DIM_GRAY
			mini_map.add_child(color_rect)
			color_rect.position = Vector2(r, f) * 6 + mini_map_marker_2d.position

func _room_entered(room):
	var room_rect_pos = Vector2(room.position.x / ROOM_SIZE.x, room.position.y / ROOM_SIZE.y) * 6 + mini_map_marker_2d.position
	player_indicator_rect.position = room_rect_pos + Vector2(1, 1)
	
