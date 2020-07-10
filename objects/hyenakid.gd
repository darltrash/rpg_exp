extends KinematicBody2D
export var velocity = Vector2()
export var maxvel = Vector2(250, 250)
var moving = false
var forceanimation = false
export var movement_enabled = true
var nextpos = Vector2.ZERO
var mode = "default"

onready var shaderbackground = $background/back0.get_material()

func _ready():
	$ontop/ColorRect.visible = true
	shaderbackground.set_shader_param("time_amp", 1.335)
	shaderbackground.set_shader_param("scale", 0.143)
	shaderbackground.set_shader_param("freq", 2.184)
	shaderbackground.set_shader_param("amp", -0.049)
	shaderbackground.set_shader_param("sp_scale", -0.362)
	shaderbackground.set_shader_param("sl_sizemultiplier", 0.8)
	shaderbackground.set_shader_param("sl_amp", 0)
	
func _process(delta):
	if mode == "default":
		moving = forceanimation
		$ontop/ColorRect.color.a = lerp($ontop/ColorRect.color.a, 0, 2 * delta)
		if movement_enabled:
			if Input.is_action_pressed("ui_left"):
				velocity.x = velocity.x - maxvel.x
				$sprite.scale.x = -4
				moving = true
			elif Input.is_action_pressed("ui_right"):
				velocity.x = velocity.x + maxvel.x
				$sprite.scale.x = 4
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
				
		move_and_slide(velocity)
			
		if moving: 
			$sprite.play("moving")
		else:
			$sprite.play("still")
	else:
		$sprite.play("still")
		$ontop/ColorRect.color.a = lerp($ontop/ColorRect.color.a, 1, 2 * delta)
		
		shaderbackground.set_shader_param("amp", lerp(shaderbackground.get_shader_param("amp"), -0.1, 0.8 * delta))
		shaderbackground.set_shader_param("freq", lerp(shaderbackground.get_shader_param("freq"), 20, 0.8 * delta))
		shaderbackground.set_shader_param("sl_amp", lerp(shaderbackground.get_shader_param("sl_amp"), 0.4, 0.4 * delta))
