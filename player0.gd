extends KinematicBody2D
var velocity = Vector2()
var maxvel = Vector2(250, 250)
var moving = false

func _process(delta):
	moving = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = velocity.x - maxvel.x
		$sprite.scale.x = -2
		moving = true
	elif Input.is_action_pressed("ui_right"):
		velocity.x = velocity.x + maxvel.x
		$sprite.scale.x = 2
		moving = true
	else:
		velocity.x = lerp(velocity.x, 0, 10 * delta)
		
	if Input.is_action_pressed("ui_up"):
		velocity.y = velocity.y - maxvel.y
		moving = true
	elif Input.is_action_pressed("ui_down"):
		velocity.y = velocity.y + maxvel.y
		moving = true
	else:
		velocity.y = lerp(velocity.y, 0, 10 * delta)
		
	velocity.x = clamp(velocity.x, -maxvel.x, maxvel.x)
	velocity.y = clamp(velocity.y, -maxvel.y, maxvel.y)
		
	if moving: 
		$sprite.play("moving")
	else:
		$sprite.play("still")
		
	move_and_slide(velocity)


