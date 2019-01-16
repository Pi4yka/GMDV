extends Area2D

func _ready():
	$AnimatedSprite.play("idle")
	
func _on_Coin_body_entered(body):
	if "Char" in body.name:
		queue_free()
		print ("coin")
