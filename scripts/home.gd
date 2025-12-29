extends Node2D 

func _ready():
	update_home_ui()
	Global.coins_changed.connect(_on_coins_changed)

func update_home_ui():
	$Stats/CoinBar/CoinLabel.text = str(Global.coins)
	$Stats/GemBar/GemLabel.text = str(Global.gems)

func _on_coins_changed(new_value):
	$Stats/CoinBar/CoinLabel.text = str(new_value)

func _on_shop_button_pressed():
	get_tree().change_scene_to_file("res://scenes/shop.tscn")
