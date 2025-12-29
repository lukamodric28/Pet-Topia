extends TextureProgressBar
@onready var hunger_label = $HungerLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = Global.hunger
	Global.hunger_changed.connect(_update_bar)
	hunger_label.text = str(int(value))

func _update_bar(new_value):
	value = new_value
	hunger_label.text = str(int(new_value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
