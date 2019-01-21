extends KinematicBody2D

const Speed = 20
const Gravity = 10
const Floor = Vector2(0, -1) 
var velocity = Vector2()
var direction = 1 
var is_dead = false
var HP_enemy = 100
var is_attaking = false
var time_cooldown_enemy = 0
var time_dead_enemy = 0
var taking_damag = false
var in_fight = false
var Char_detektor = false

func move():
	velocity.x = Speed * direction
			
	if direction == 1: # Меняет направленность анимации бега
		$AnimatedSprite.flip_h = false
		
	else:
		$AnimatedSprite.flip_h = true
			
	
	$AnimatedSprite.play("run")
	velocity.y += Gravity	
	velocity = move_and_slide(velocity, Floor)
	
	if $RayCast2D.is_colliding() == false : # Столкновение с обрывом 
		direction = direction * -1  
		$RayCast2D.position.x *= -1
		$Ray_enemy.position.x  *= -1
		$Ray_enemy.cast_to  *= -1
		$Detector.position.x  *= -1
		$Detector.cast_to  *= -1		

func dead(): # Убивает врага
	$AnimatedSprite.play("dead")
	velocity = Vector2(0, 0)
	is_dead = true
	$run.disabled = true
	$Timer_dead.start()
	
func damage():
	HP_enemy -= G.damage_Char
	in_fight = true
	is_attaking = true
	taking_damag = true
	if HP_enemy > 0 and taking_damag:
		velocity = Vector2(0, 0)
		$AnimatedSprite.play("taking_damage")
	if HP_enemy == 0:
		dead()
		
func attake(ray_ataking):
	if  is_attaking == false:
		time_cooldown_enemy = 0
		if is_on_floor():
			velocity.x = 0
			is_attaking = true
			in_fight = true
		var Char = ray_ataking.get_collider()
		if Char.has_method('dead_playr'):
			$AnimatedSprite.play("swing")
			if taking_damag == false:
				Char.dead_playr()

func char_detector(Ray_enemy, Char_detect):
	if Ray_enemy.is_colliding() : #Атака по герою если он стоит слева
		Char_detect = Ray_enemy.get_collider()
		if Char_detect.has_method('dead_playr'):
			Char_detect = true
			return Char_detect
		else:
			Char_detect = false
			return Char_detect
	else:
		Char_detect = false
		return Char_detect
	

func _physics_process(delta):
	if is_dead == false and HP_enemy > 0:
		#time_cooldown_enemy += delta
		
							
		if is_attaking == false and in_fight == false:
			move()
			if is_on_wall() : # Столкновение со стенами 
				direction = direction * -1 
				$RayCast2D.position.x *= -1 # Разворачивает RayCast2D при повороте спрайта
				$Ray_enemy.position.x  *= -1
				$Ray_enemy.cast_to  *= -1
				$Detector.position.x  *= -1
				$Detector.cast_to  *= -1	
		if $Detector.is_colliding():
			if char_detector($Detector, Char_detektor):
				in_fight = true
		else:
			in_fight = false
			
		if in_fight == true and is_attaking == false:
			move()
			if $Ray_enemy.is_colliding():
				attake($Ray_enemy)
			else:
				in_fight = false
		
			
				

func _on_AnimatedSprite_animation_finished(): # даёт возможность проиграть анимацию атаки
	is_attaking = false
	taking_damag = false
	


func _on_Timer_dead_timeout():
	queue_free()
