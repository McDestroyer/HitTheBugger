extends CanvasLayer

func set_gold(value: float):
	$GoldCounter.text = str(int(value)) + " Gold"
