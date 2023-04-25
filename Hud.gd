extends CanvasLayer

var coins : int

func add_coins():
	coins += 1
	$"Coins Display".text = "Coins collected: " + str(coins)
	
func win():
	$"Win!".text = "You won!"
