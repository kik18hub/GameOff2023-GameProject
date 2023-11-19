extends Node2D

const ROOM = preload("res://scenes/room.tscn")
const ROOM_SIZE = Vector2(320, 160)

@export var floor_count := 5

@onready var mini_map: Node2D = $CanvasLayer/Panel/RoomRectContainer
@onready var mini_map_marker_2d: Marker2D = $CanvasLayer/Panel/Marker2D
@onready var room_container: Node2D = $RoomContainer
@onready var player_indicator_rect: ColorRect = $CanvasLayer/Panel/PlayerIndicator


var room_count_per_floor := 3
var room_coors: Array




func _ready() -> void:
	Events.root_entered.connect(_room_entered)
	room_coors = RoomGeneration.generate_rooms()
	_add_room()
	_draw_mini_map()
	

func _add_room():
	for room_coor in room_coors:
		var room = ROOM.instantiate()
		if room_coors.has(room_coor + Vector2(0, -1)):
			room.has_up_door = true
		if room_coors.has(room_coor + Vector2(1, 0)):
			room.has_right_door = true
		if room_coors.has(room_coor + Vector2(0, 1)):
			room.has_down_door = true
		if room_coors.has(room_coor + Vector2(-1, 0)):
			room.has_left_door = true
		room_container.add_child(room)
		room.position = Vector2(
			ROOM_SIZE.x * room_coor.x,
			ROOM_SIZE.y * room_coor.y)
	
	
func _draw_mini_map():
	for room_coor in room_coors:
		var color_rect = ColorRect.new()
		color_rect.size = Vector2(5, 5)
		color_rect.color = Color.DARK_GRAY
		mini_map.add_child(color_rect)
		color_rect.position = room_coor * 6 + mini_map_marker_2d.position


func _room_entered(room):
	var room_rect_pos = Vector2(room.position.x / ROOM_SIZE.x, room.position.y / ROOM_SIZE.y) * 6 + mini_map_marker_2d.position
	player_indicator_rect.position = room_rect_pos + Vector2(1, 1)
	
