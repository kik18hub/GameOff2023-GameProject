extends Control

signal textbox_closed

func _ready():
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	
	$TextBox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild Sprite appears!")
	await self.textbox_closed
	$ActionsPanel.show()

func set_health(progress_bar, health, max_health):
	progress_bar.value = health
	progress_bar.max_value = max_health
	progress_bar.get_node("Label").text = "HP: %d/%d" % [health, max_health]

func _input(event):
	if (Input.is_action_just_pressed("ui_accept") or Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)) and $TextBox.visible:
		$TextBox.hide()
		emit_signal("textbox_closed")

func display_text(text):
	$TextBox.show()
	$TextBox/Label.text = text


func _on_run_pressed():
	display_text("Got away safely!")
	await self.textbox_closed
	get_tree().quit()
