extends Control

func _ready():
	$WarningLabel.hide()
	update_ui()
	
func update_ui():
	$Stats/CoinBar/CoinLabel.text = str(Global.coins)
	$Stats/GemBar/GemLabel.text = str(Global.gems)
	
	$GridContainer/ApplePanel/AppleOwned.text = "Owned: " + str(Global.food_inventory["Apple"])
	$GridContainer/PizzaPanel/PizzaOwned.text = "Owned: " + str(Global.food_inventory["Pizza"])
	$GridContainer/MeatPanel/MeatOwned.text = "Owned: " + str(Global.food_inventory["Meat"])
	$GridContainer/FishPanel/FishOwned.text = "Owned: " + str(Global.food_inventory["Fish"])

func _on_apple_buy_button_pressed():
	if Global.buy_item("Apple", 10):
		update_ui() 
		$WarningLabel.hide()
	else:
		show_error("Not Enough Coins!")

func _on_pizza_buy_button_pressed():
	if Global.buy_item("Pizza", 25):
		update_ui()
		$WarningLabel.hide()
	else:
		show_error("Not Enough Coins!")

func _on_meat_buy_button_pressed():
	if Global.buy_item("Meat", 40):
		update_ui()
		$WarningLabel.hide()
	else:
		show_error("Not Enough Coins!")

func _on_fish_buy_button_pressed():
	if Global.buy_item("Fish", 15):
		update_ui()
		$WarningLabel.hide()
	else:
		show_error("Not Enough Coins!")
		
func _on_home_button_pressed():
	get_tree().change_scene_to_file("res://scenes/home.tscn")
		
func show_error(message: String):
	$WarningLabel.text = message
	$WarningLabel.show()
	await get_tree().create_timer(2.0).timeout
	$WarningLabel.hide()
