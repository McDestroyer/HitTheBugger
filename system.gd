extends Node2D

var _gold = 0

var gold_increment = 1
var crit_multiplier = 2

var hit_type_func_dict = {
	HitTypes.BASIC: _basic_hit,
	HitTypes.CRITICAL: _crit_hit,
}

func _physics_process(delta: float) -> void:
	pass

func hit(hit_type):
	_gold += hit_type_func_dict[hit_type].call()
	$HUD.set_gold(_gold)



func _basic_hit():
	return gold_increment

func _crit_hit():
	return gold_increment * crit_multiplier

enum HitTypes {
	BASIC = 0,
	CRITICAL = 1
}
