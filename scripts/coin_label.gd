extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Global.coins)
	Global.coins_changed.connect(_on_coins_changed)
	
func _on_coins_changed(new_value):
	text = str(new_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
