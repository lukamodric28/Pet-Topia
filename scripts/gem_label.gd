extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = str(Global.gems)
	Global.gems_changed.connect(_on_gems_changed)

func _on_gems_changed(new_value):
	text = str(new_value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
