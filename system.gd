extends Node2D

var _gold: float = 0

var gold_increment: NumberSum = NumberSum.new(1)
var crit_multiplier: NumberSum = NumberSum.new(2)

var hit_type_func_dict = {
	HitTypes.BASIC: _basic_hit,
	HitTypes.CRITICAL: _crit_hit,
}

var activated_effects: Array[Effect] = []

func _physics_process(delta: float) -> void:
	#$Store.get_selected_items()

	for effect in activated_effects:
		effect.loop_func.call(delta)

	print(gold_increment.output_val)

func hit(hit_type):
	_gold += hit_type_func_dict[hit_type].call()
	$HUD.set_gold(_gold)
	print(_gold)



func _basic_hit() -> float:
	return gold_increment.recalculate()

func _crit_hit():
	#Effect.new("Name", "Icon_path", 5, null, _basic_hit, _basic_hit, _basic_hit)
	return _basic_hit() * crit_multiplier.recalculate()
	

enum HitTypes {
	BASIC,
	CRITICAL
}
