extends CanvasLayer

func set_gold(value: float):
	$GoldCounter.text = str(int(value)) + " Gold"


func _on_store_button_pressed() -> void:
	$"../Store".visible = !$"../Store".visible
