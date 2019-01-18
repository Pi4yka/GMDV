extends KinematicBody2D


const Speed = 60
const Gravity = 10
const Jump_P = -198
const Floor = Vector2(0, -1)
var attack = false
var velocity = Vector2()
var onground = false

var is_attaking = false
var dead_playr = false
var time_cooldown = 0

func dead_playr():
	G.HP_Char -= global_enemy.damage_enemy
	print(G.HP_Char)
	

func _physics_process(delta):
	if dead_playr == false and G.HP_Char > 0:
		if Input.is_action_pressed("ui_right"):
			if is_attaking == false:
				velocity.x = Speed
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("ui_left"):
			if is_attaking == false:	
				velocity.x = -Speed
				$AnimatedSprite.play("Run")
				$AnimatedSprite.flip_h = true
		else:
			velocity.x = 0
			if is_attaking == false:	
				$AnimatedSprite.play("idle")
				#$Swing.disabled = true
			
		if Input.is_action_pressed("ui_up"):
			if is_attaking == false:	
				if onground == true:
					velocity.y = Jump_P
					onground = false
					if velocity.y < 0:
						$AnimatedSprite.play("jump")
					else:
						$AnimatedSprite.play("fall")
		time_cooldown += delta
		if Input.is_action_just_pressed("ui_focus_next") and is_attaking == false and time_cooldown > 0.6 and G.MP_Char > 0:
			if is_on_floor():
				velocity.x = 0
			is_attaking = true
			$AnimatedSprite.play("swing")
			#$Swing.disabled = false
			if $Ray_raiht.is_colliding() :
				var enemy = $Ray_raiht.get_collider()
				if enemy.has_method('dead'):
					enemy.damage()
					G.MP_Char -= 10 # Вычитание стамины при атаке
					print (1)
			if $Ray_left.is_colliding() :
				var enemy2 = $Ray_left.get_collider()
				if enemy2.has_method('dead'):
					enemy2.damage()
					G.MP_Char -= 10 # Вычитание стамины при атаке
					print(2)
			time_cooldown = 0
			
		
	
	velocity.y += Gravity
	if is_on_floor():
		if onground == false:
			is_attaking = false
			if G.MP_Char < 100: # прибовление стамины после атаки
				G.MP_Char += 10
		onground = true
	else:
		if is_attaking == false:	
			onground = false
		
	
	
		
	velocity = move_and_slide(velocity, Floor)
	
	
	
	

func _on_AnimatedSprite_animation_finished():
	is_attaking = false
