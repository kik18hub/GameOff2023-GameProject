extends Control

signal textbox_closed

@export var enemy:Resource
@export var orc:Resource
@export var mushroom:Resource
@export var imp:Resource

var current_player_health = 0
var current_enemy_health = 0
var current_orc_health = 0
var current_imp_health = 0
var current_mushroom_health = 0
var is_defending = false

func _ready():
	set_health($EnemyContainer/ProgressBar, enemy.health, enemy.health)
	set_health($PlayerPanel/PlayerData/ProgressBar, State.current_health, State.max_health)
	$EnemyContainer/Enemy.texture = enemy.texture
	
	set_health($OrcContainer/ProgressBar, orc.health, orc.health)
	$OrcContainer/Enemy.texture = orc.texture
	set_health($ImpContainer/ProgressBar, imp.health, imp.health)
	$ImpContainer/Enemy.texture = imp.texture
	set_health($MushroomContainer/ProgressBar, mushroom.health, mushroom.health)
	$MushroomContainer/Enemy.texture = mushroom.texture
	
	current_player_health = State.current_health
	current_enemy_health = enemy.health
	current_orc_health = orc.health
	current_imp_health = imp.health
	current_mushroom_health = mushroom.health
	
	$TextBox.hide()
	$ActionsPanel.hide()
	
	display_text("A wild %s appears!" % enemy.name.to_upper())
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
	$ActionsPanel.hide()
	$TextBox.show()
	$TextBox/Label.text = text

func enemy_turn():
	display_text("%s launches an attack!" % enemy.name.to_upper())
	await self.textbox_closed
	
	if is_defending:
		is_defending = false
		display_text("You defended successfully!")
		current_player_health = max(0, current_player_health - enemy.def)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s dealt %d damage!" % [enemy.name, enemy.def])
		await self.textbox_closed
	else:
		current_player_health = max(0, current_player_health - enemy.enemyAttackNeu)
		set_health($PlayerPanel/PlayerData/ProgressBar, current_player_health, State.max_health)
		display_text("%s dealt %d damage!" % [enemy.name, enemy.enemyAttackNeu])
		await self.textbox_closed
	
	$ActionsPanel.show()

func _on_run_pressed():
	display_text("Got away safely!")
	await self.textbox_closed
	get_tree().quit()


func _on_attack_pressed():
	display_text("You attack the enemy!")
	await self.textbox_closed
	
	if "Physical" in enemy.eneType:
		if "Nature" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkCrit)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkCrit)
			await self.textbox_closed

	if "Spell" in enemy.eneType:
		if "Physical" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkCrit)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkCrit)
			await self.textbox_closed
	
	if "Nature" in enemy.eneType:
		if "Spell" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkCrit)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkCrit)
			await self.textbox_closed

	if "Nature" in enemy.eneType:
		if "Physical" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkRes)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkRes)
			await self.textbox_closed
				
	if "Physical" in enemy.eneType:
		if "Spell" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkRes)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkRes)
			await self.textbox_closed
				
	if "Spell" in enemy.eneType:
		if "Nature" in State.AtkType:
			current_enemy_health = max(0, current_enemy_health - State.playerAtkRes)
			set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
			display_text("You dealt %d damage!" % State.playerAtkRes)
			await self.textbox_closed
	else:
		current_enemy_health = max(0, current_enemy_health - State.playerAttackNeu)
		set_health($EnemyContainer/ProgressBar, current_enemy_health, enemy.health)
		display_text("You dealt %d damage!" % State.playerAttackNeu)
		await self.textbox_closed
	
	if current_enemy_health == 0:
		display_text("%s was defeated!" % enemy.name)
		await self.textbox_closed
		
		get_tree().quit
		
	enemy_turn()


func _on_defend_pressed():
	is_defending = true
	
	display_text("You've prepared your defense!")
	await self.textbox_closed
	
	enemy_turn()
