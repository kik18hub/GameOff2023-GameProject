extends Node

enum RoomTypes {
	START,
	END,
	BATTLE,
	CHEST,
	BLOCK,
	EMPTY
}

var floor_count := 5
var room_count_per_floor := 3
var battle_room_count_per_floor := 1
var chest_room_count_per_floor := 1
var block_room_count_per_floor := 1

func generate_rooms():
	var rooms = [].resize(floor_count)
	for 
	
	if room_count_per_floor < battle_room_count_per_floor + chest_room_count_per_floor + block_room_count_per_floor:
		return []
	var rooms = [Vector2(0, 0)]
	for i in range(floor_count):
		for j in range(room_count_per_floor):
			rooms.append(Vector2(j - floor(room_count_per_floor / 2), - (i + 1)))
	rooms.append(Vector2(0, - (floor_count + 1)))
	return rooms
