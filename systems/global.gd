extends Node

signal hunger_changed(new_value)
signal coins_changed(new_value)
signal gems_changed(new_value)
signal energy_changed(new_value)

const SAVE_PATH := "user://save_data.json"

var is_loading : bool = false

var coins : int = 50:
	set(value):
		coins = max(0, value)
		coins_changed.emit(coins)
		save_data()

var gems : int = 50:
	set(value):
		gems = max(0, value)
		gems_changed.emit(gems)
		save_data()

var hunger : int = 100:
	set(value):
		hunger = clampi(value, 0, 100)
		hunger_changed.emit(hunger)
		save_data()
		
var energy : int = 100:
	set(value):
		energy = clampi(value, 0, 100)
		energy_changed.emit(energy)
		save_data()
		
func _ready():
	load_data()
	var timer = Timer.new()
	timer.wait_time = 3.0 
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(_on_hunger_timer_timeout)

func _on_hunger_timer_timeout():
	if hunger > 0:
		hunger -= 1
		print("Pet is getting hungry! Current hunger: ", hunger)

var food_inventory: Dictionary = {
	"Apple": 0,
	"Meat": 0, 
	"Pizza": 0,
	"Fish": 0
}

func add_coins(amount):
	self.coins += amount
	
func add_gems(amount):
	self.gems += amount
	
func buy_item(item_name: String, cost: int):
	if coins >= cost:
		self.coins -= cost
		food_inventory[item_name] += 1
		save_data() 
		return true 
	return false
	
func save_data() -> void:
	return
	if is_loading:
		return
	var data: Dictionary = {
		"coins": coins,
		"gems": gems,
		"food": food_inventory,
		"hunger": hunger,
		"energy": energy
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()	
	
func load_data() -> void:
	return
	if FileAccess.file_exists(SAVE_PATH):
		is_loading = true
		var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
		var content: String = file.get_as_text()
		file.close()

		var result: Dictionary = JSON.parse_string(content)
		if typeof(result) == TYPE_DICTIONARY:
			coins = result.get("coins", 50)
			gems = result.get("gems", 50)
			food_inventory = result.get("food", food_inventory)
			hunger = result.get("hunger", 100)
			energy = result.get("energy", 100)
		is_loading = false
		
