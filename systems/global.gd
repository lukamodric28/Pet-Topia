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

var hunger : int = 50:
	set(value):
		hunger = clampi(value, 0, 100)
		hunger_changed.emit(hunger)
		save_data()
		
var energy : int = 50:
	set(value):
		energy = clampi(value, 0, 100)
		energy_changed.emit(energy)
		save_data()

var food_inventory: Dictionary = {
	"Apple": 5,
	"Meat": 5, 
	"Pizza": 5,
	"Fish": 5
}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_data()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func add_coins(amount):
	coins += amount
	
func add_gems(amount):
	gems += amount
	
func save_data() -> void:
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
			hunger = result.get("hunger", 50)
			energy = result.get("energy", 50)
		is_loading = false
