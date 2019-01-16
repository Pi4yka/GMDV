extends KinematicBody2D

var coin = false
const Speed = 60
const Gravity = 10
const Jump_P = -250
const Floor = Vector2(0, -1)
var attack = false

var velocity = Vector2()

var onground = false 

func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		velocity.x = Speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):	
		velocity.x = -Speed
		$AnimatedSprite.play("Run")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")
	if Input.is_action_pressed("ui_up"):
		if onground == true:
			velocity.y = Jump_P
			onground = false
			if velocity.y < 0:
				$AnimatedSprite.play("jump")
			else:
				$AnimatedSprite.play("fall")
	velocity.y += Gravity
	if is_on_floor():
		onground = true
	else:
		onground = false	
	velocity = move_and_slide(velocity, Floor)
	
	
	

	