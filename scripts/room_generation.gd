extends Node

enum RoomTypes {
	START,
	END,
	BATTLE,
	CHEST,
	BLOCK,
	EMPTY
}

enum DoorTypes {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT
}

enum Directions {
	TOP,
	RIGHT,
	BOTTOM,
	LEFT
}

const DIRECTIONS = [Vector2(0, -1), Vector2(1, -0), Vector2(0, 1), Vector2(-1, 0)]

var floor_count := 7
var room_count_per_floor := 5
var battle_room_count_per_floor := 1
var chest_room_count_per_floor := 1
var block_room_count_per_floor := 1

func generate_rooms():
	var all_rooms: Array = []
	all_rooms.resize(floor_count + 2)
	for floor in range(len(all_rooms)):
		all_rooms[floor] = []
		all_rooms[floor].resize(room_count_per_floor)
	
	all_rooms[0][floor(room_count_per_floor / 2)] = {
		type = RoomTypes.END,
		doors = [DoorTypes.BOTTOM]
	}
	all_rooms[floor_count + 1][floor(room_count_per_floor / 2)] = {
		type = RoomTypes.START,
		doors = [DoorTypes.TOP]
	}
	
	if room_count_per_floor < battle_room_count_per_floor + chest_room_count_per_floor + block_room_count_per_floor:
		return []
	
	# generate rooms
	for f in range(1, floor_count + 1):
		for r in range(room_count_per_floor):
			all_rooms[f][r] = {
				type = RoomTypes.EMPTY
			}
	
	# change room type
	for f in range(1, floor_count + 1):
		var battle_room_count = battle_room_count_per_floor
		var chest_room_count = chest_room_count_per_floor
		var block_room_count = block_room_count_per_floor
		var room_index_in_floor = []
		
		# randomly pick room in a floor
		for r in range(room_count_per_floor):
			room_index_in_floor.append(r)
		room_index_in_floor.shuffle()
		
		for r in room_index_in_floor:
			var available_types = [RoomTypes.EMPTY]
			if battle_room_count > 0:
				available_types.append(RoomTypes.BATTLE)
			if chest_room_count > 0:
				available_types.append(RoomTypes.CHEST)
			if block_room_count > 0:
				available_types.append(RoomTypes.BLOCK)
				
			if (all_rooms[f - 1][r] != null and all_rooms[f - 1][r].type == RoomTypes.END) or (all_rooms[f + 1][r] != null and all_rooms[f + 1][r].type == RoomTypes.START):
				available_types = available_types.filter(func(type): return type != RoomTypes.BLOCK)
				
			var pick_type = available_types[randi_range(0, len(available_types) - 1)]
			match pick_type:
				RoomTypes.BATTLE:
					battle_room_count -= 1
				RoomTypes.CHEST:
					chest_room_count -= 1
				RoomTypes.BLOCK:
					block_room_count -= 1
			
			all_rooms[f][r] = {
				type = pick_type
			}
			
	# add doors		
	for f in range(1, floor_count + 1):
		for r in range(room_count_per_floor):
			var doors = []
			for direction in DIRECTIONS:
				var check_floor_index = f + direction.y
				var check_room_index = r + direction.x
				if check_floor_index == 0 or \
					check_floor_index == floor_count + 2 or \
					check_room_index < 0 or \
					check_room_index >= room_count_per_floor or \
					all_rooms[check_floor_index][check_room_index] == null or \
					all_rooms[check_floor_index][check_room_index].type == RoomTypes.BLOCK:
					continue
				
				match direction:
					Vector2(0, -1):
						doors.append(DoorTypes.TOP)
					Vector2(1, 0):
						doors.append(DoorTypes.RIGHT)
					Vector2(0, 1):
						doors.append(DoorTypes.BOTTOM)
					Vector2(-1, 0):
						doors.append(DoorTypes.LEFT)
			all_rooms[f][r].doors = doors
	
	print(all_rooms)
	return all_rooms

