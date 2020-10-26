extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAX_SPEED = 150
const ACCELERATION = 20
const JUMP_HEIGHT = -280
const BULLET = preload("res://Bullet.tscn")

var motion = Vector2()
var velocity = Vector2()
var is_dead = false


func _physics_process(delta):
	if position.y > 1000:
		get_tree().reload_current_scene()
	if position.y > 400:
		$Sprite.play("Death")

	motion.y += GRAVITY
	var friction = false
	
	if is_dead == false:
		if Input. is_action_pressed("ui_right"):
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("Run")
			if sign($Position2D.position.x) == -1:
				$Position2D.position.x *= -1
		elif Input. is_action_pressed("ui_left"):
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("Run")
			if sign($Position2D.position.x) == 1:
				$Position2D.position.x *= -1
		else:
			friction = true
			motion.x = lerp(motion.x,0,0.2)
			$Sprite.play("Idle")
		
		if Input. is_action_just_pressed("ui_accept") and PlayerStats.has_ammo():
			
			PlayerStats.change_ammo(-1)
			
			var bullet = BULLET.instance()
			if sign($Position2D.position.x) == 1:
				bullet.set_bullet_direction(1)
			else:
				bullet.set_bullet_direction(-1)
				
			get_parent().add_child(bullet)
			bullet.position = $Position2D.global_position
		
		if is_on_floor():
			if Input. is_action_just_pressed("ui_up"):
				motion.y = JUMP_HEIGHT
			if friction == true:
				motion.x = lerp(motion.x,0,0.2)
				
		else:
			$Sprite.play("Jump")
			if friction == true:
				motion.x = lerp(motion.x,0,0.05)
		
		
			
		
					
					
			
		motion = move_and_slide(motion, UP)
		pass

func dead():
	is_dead = true
	velocity = Vector2(0, 0)
	$Sprite.play("Death")
	$CollisionShape2D.disabled = true
	yield($Sprite,"animation_finished")
	$CollisionShape2D.disabled = false
	PlayerStats.readyup()
	get_tree().reload_current_scene()
	
	

func _on_Timer_timeout():
	get_tree().reload_current_scene()


#func _on_Area2D_area_entered(area):
#	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if body.filename == "res://Enemy.tscn":
		PlayerStats.change_health(-34)
	if PlayerStats.get_health() == 0:
		dead()
	if body.filename == "res://Spike.tscn":
		dead()
	

	pass # Replace with function body.
