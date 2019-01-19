extends CanvasLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	$HP.text = 'HP:' +str(G.HP_Char)
	$MP.text = 'MP:' +str(G.MP_Char)
	$Potion.text = 'Potion:' +str(G.potion_amount)
	$Coin.text = 'Coin:' +str(G.coin_amount)