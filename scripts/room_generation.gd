extends Node


func generate_rooms(floor_count: int, room_count_per_floor: int):
	var rooms = [Vector2(0, 0)]
	for i in range(floor_count):
		for j in range(room_count_per_floor):
			rooms.append(Vector2(j - floor(room_count_per_floor / 2), - (i + 1)))
	rooms.append(Vector2(0, - (floor_count + 1)))
	return rooms
