extends Resource

@export var name:String
@export var texture:Texture
@export var health:int
@export var damage:int
var eA = 1.5
var B = 20
var pD = 10
var m = 2
var enemyAttack = ((eA * B) /pD) * m
var def = (((eA * B) /pD) * m) / 2
