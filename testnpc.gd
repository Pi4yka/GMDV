extends Area2D

var chat = false
func _ready():
	$AnimatedSprite.play("idle")


func _on_NPC_body_entered(body):
	if "Char" in body.name:
		chat = true
		print ("chat")
	
	
#func chat_with():
	
			
		
