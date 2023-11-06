extends CharacterBody2D

const SPEED = 70

var input_direction = Vector2.ZERO
var sprite_direction = "Down"

@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	input_direction = _get_input_direction()
	velocity = input_direction * SPEED
	move_and_slide()

	set_animation(sprite_direction)
	if velocity == Vector2.ZERO:
		sprite.stop()

func set_animation(animation):
	var direction = sprite_direction
	if sprite_direction in ["Left", "Right"]:
		sprite.play("walkSide")
	sprite.play("walkDown")
	sprite.flip_h = (sprite_direction == "Left")

func _get_input_direction():
	return Vector2(-int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right")), -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down")))

func _get_sprite_direction():
	return input_direction.normalized()
