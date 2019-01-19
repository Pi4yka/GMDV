extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	$AnimatedSprite.play("idle")
	





func _on_NPC_body_entered(body):
	if "Char" in body.name:
		print ("enter npc")
		G.NPC_chat = true
		
		
		


func _on_NPC_body_exited(body):
	if "Char" in body.name:
		print ("exited npc")
		G.NPC_chat = false
