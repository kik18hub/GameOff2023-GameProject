extends Resource

@export var name:String
@export var texture:Texture
@export var health:int
@export var eA = 5
var eneType = ["Physical", "Spell", "Nature"]

var B = 20
var pD = 10
var m = 2
var enemyAttackNeu = ((eA * B) /pD) * m
var def = (((eA * B) /pD) * m) / 2
var enemyAtkCrit = (((eA * B) /pD) * m) * 2
var enemyAtkRes = (((eA * B) /pD) * m) * 0.5

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
