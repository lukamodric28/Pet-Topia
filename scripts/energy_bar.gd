extends TextureProgressBar
@onready var energy_label = $EnergyLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value = Global.energy
	Global.energy_changed.connect(_update_bar)
	energy_label.text = str(int(value))
	
func _update_bar(new_value):
	value = new_value
	energy_label.text = str(int(new_value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
