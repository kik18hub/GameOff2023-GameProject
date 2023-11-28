extends Resource

@export var name:String
@export var texture:Texture
@export var health:int
@export var eA = 5
var eneType = ["Physical", "Spell", "Nature"]

var B = 20
var pD = 10
var m = 2
var impAttackNeu = ((eA * B) /pD) * m
var def = (((eA * B) /pD) * m) / 2
var impAtkCrit = (((eA * B) /pD) * m) * 2
var impAtkRes = (((eA * B) /pD) * m) * 0.5

var Physical
var Spell
var Nature
var Neutral

var Single
var Multiple

var AtkName:String
var AtkDmg:int
var AtkType = ["Physical", "Spell", "Nature", "Neutral"]
var AtkTarget = ["Single", "Multiple"]

var impNorAtk = {
	AtkName = "Normal Attack",
	AtkDmg = 4,
	AtkType = "Physical",
	AtkTarget = "Single"
}

var impCurse = {
	AtkName = "Curse",
	AtkDmg = 12,
	AtkType = "Spell",
	AtkTarget = "Single"
}

var impRite = {
	AtkName = "Lost Rites",
	AtkDmg = 15,
	AtkType = "Spell",
	AtkTarget = "Single"
}

var impAttacks = [impNorAtk, impCurse, impRite]
@export var impType = "Spell"
