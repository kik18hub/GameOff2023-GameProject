extends Resource

@export var name:String
@export var texture:Texture
@export var health:int
@export var eA = 5
var eneType = ["Physical", "Spell", "Nature"]

var B = 20
var pD = 10
var m = 2
var mushAttackNeu = ((eA * B) /pD) * m
var def = (((eA * B) /pD) * m) / 2
var mushAtkCrit = (((eA * B) /pD) * m) * 2
var mushAtkRes = (((eA * B) /pD) * m) * 0.5

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

var mushNorAtk = {
	AtkName = "Normal Attack",
	AtkDmg = 4,
	AtkType = "Physical",
	AtkTarget = "Single"
}

var mushConfuse = {
	AtkName = "Confuse",
	AtkDmg = 12,
	AtkType = "Nature",
	AtkTarget = "Single"
}

var mushSpores = {
	AtkName = "Spiky Spores",
	AtkDmg = 15,
	AtkType = "Nature",
	AtkTarget = "Single"
}

var mushAttacks = [mushNorAtk, mushConfuse, mushSpores]
@export var mushType = "Nature"

