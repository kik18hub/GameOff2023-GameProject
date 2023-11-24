extends Node

var current_health = 35
var max_health = 35
var damage = 5

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

var norAtk = {
	AtkName = "Normal Attack",
	AtkDmg = 7,
	AtkTarget = "Single",
	AtkType = "Physical"
}

var fireballAtk = {
	AtkName = "Fireball",
	AtkDmg = 15,
	AtkTarget = "Single",
	AtkType = "Spell"
}

var natAtk = {
	AtkName = "Piercing Wind",
	AtkDmg = 15,
	AtkTarget = "single",
	AtkType = "Nature"
}

var playAttacks = [norAtk, fireballAtk, natAtk]

var pA = 1.5
var B = 20
var eD = 10
var m = 2
var playerAttackNeu = ((pA * B) /eD) * m
var playerAtkCrit = (((pA * B) /eD) * m) * 2
var playerAtkRes = (((pA * B) /eD) * m) * 0.5
