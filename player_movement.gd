extends CharacterBody2D

@export var speed = 70

var input_direction: get = _get_input_direction 
var sprite_direction = "Down": get = _get_sprite_direction

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	velocity = input_direction * speed
	move_and_slide()

	set_animation("Walk")
	if velocity == Vector2.ZERO:
		sprite.stop()
		
func player():
	pass

func set_animation(animation):
	var direction = "Side" if sprite_direction in ["Left", "Right"] else sprite_direction
	sprite.play(animation + direction)
	sprite.flip_h = (sprite_direction == "Left")

func _get_input_direction():
	var x = -int(Input.is_key_label_pressed(KEY_A)) + int(Input.is_key_label_pressed(KEY_D))
	var y = -int(Input.is_key_label_pressed(KEY_W)) + int(Input.is_key_label_pressed(KEY_S))
	input_direction = Vector2(x,y).normalized()
	return input_direction

func _get_sprite_direction():
	match input_direction:
		Vector2.LEFT:
			sprite_direction = "Left"
		Vector2.RIGHT:
			sprite_direction = "Right"
		Vector2.UP:
			sprite_direction = "Up"
		Vector2.DOWN:
			sprite_direction = "Down"
	return sprite_direction
