extends Node
var health
var health_max
var ammo
var ammo_max

func readyup():
	health = 100

	
func _ready():
	health = 100
	health_max = 100
	ammo = 8
	ammo_max = 8
	
func change_health(amount):
	health += amount
	health = clamp(health,0, health_max)
	
func change_ammo(amount):
	ammo += amount
	ammo = clamp(ammo,0,ammo_max)
	
func get_health():
	return health
	
func get_ammo():
	return str(ammo)
	
func has_ammo():
	return ammo > 0
