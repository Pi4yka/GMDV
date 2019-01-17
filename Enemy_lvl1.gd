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

func dead():
	$AnimatedSprite.play("dead")
	velocity = Vector2(0, 0)
	is_dead = true
	if is_dead == true:
		$AnimatedSprite.play("corpse")
	
	
func damage():
	HP_enemy -= G.damage_Char
	if HP_enemy == 0:
		dead()
	


func _physics_process(delta):
	if is_dead == false and HP_enemy > 0:
		time_cooldown_enemy += delta
		if $Ray_right_enemy.is_colliding() and is_attaking == false and time_cooldown_enemy > 1.5: #Атака по герою если он стоит справа 
			time_cooldown_enemy = 0
			if is_on_floor():
				velocity.x = 0
				is_attaking = true
			var Char = $Ray_right_enemy.get_collider()
			if Char.has_method('dead_playr'):
				$AnimatedSprite.flip_h = false
				$AnimatedSprite.play("swing")
				Char.dead_playr()
				
				
		if $Ray_left_enemy.is_colliding() and is_attaking == false and time_cooldown_enemy > 1.5: #Атака по герою если он стоит слева
			time_cooldown_enemy = 0
			if is_on_floor():
				velocity.x = 0
				is_attaking = true
			var Char2 = $Ray_left_enemy.get_collider()
			if Char2.has_method('dead_playr'):
				$AnimatedSprite.flip_h = true
				$AnimatedSprite.play("swing")
				Char2.dead_playr()
				
		if is_attaking == false: 
			velocity.x = Speed * direction
			
			if direction == 1: # Меняет направленность анимации бега
				$AnimatedSprite.flip_h = false
			else:
				$AnimatedSprite.flip_h = true
			
			$AnimatedSprite.play("run")
			velocity.y += Gravity	
			velocity = move_and_slide(velocity, Floor)
			
			if is_on_wall(): # Столкновение со стенами 
				direction = direction * -1 
				$RayCast2D.position.x *= -1 # Разворачивает RayCast2D при повороте спрайта 
				
			if $RayCast2D.is_colliding() == false: # Столкновение с обрывом 
				direction = direction * -1 
				$RayCast2D.position.x *= -1
		
		

func _on_AnimatedSprite_animation_finished(): # даёт возможность проиграть анимацию атаки
	is_attaking = false
	
