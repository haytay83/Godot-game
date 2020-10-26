extends Area2D

const SPEED = 180
var velocity = Vector2()
var direction = 1

func set_bullet_direction(dir):
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta):
	velocity.x = SPEED * delta * direction
	translate(velocity)
	$AnimatedSprite.play("shoot")



func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()


func _on_Bullet_body_entered(body):
	if "Enemy" in body.name:
		body.dead()
	queue_free()
