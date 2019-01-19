extends Area2D

func _on_Potion_body_entered(body):
	if "Char" in body.name:
		G.potion_amount += 1
		queue_free()
		print ("potion")
