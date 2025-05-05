extends Node
class_name NumberSum

## The bottom-level default value before any modifiers.
var base_value: float = 0
## The values to be added to the base value before multipliers.
var sum_dict: Dictionary[String, float] = {}
## The values to be added together then multiplied on the base value.
## Starts at 1; add negative values for decreases.
var mult_dict: Dictionary[String, float] = {}
## A flag indicating that at least one of the values was changed and the output
## needs to be regenerated.
var changed: bool = false
## The value output. Only updated occasionally to save processing power.
@export
var output_val: float = 0


func _init(base) -> void:
	base_value = base
	changed = true
	recalculate()

## Change the base value of the number (before all additions and multiplications)
func change_base(new_base) -> void:
	if new_base != base_value:
		changed = true
		base_value = new_base

## Update the id's sum value to the given val.
func set_sum_val(id: String, val: float) -> void:
	if !sum_dict.has(id) or sum_dict[id] != val:
		changed = true
		sum_dict[id] = val

## Update the id's mult value to the given val.
func set_mult_val(id: String, val: float) -> void:
	if !mult_dict.has(id) or mult_dict[id] != val:
		changed = true
		mult_dict[id] = val

## Recalculates the output value if the changed flag is set then returns it.
func recalculate() -> float:
	if changed:
		output_val = base_value
		
		# Add the sum vals.
		for num in sum_dict.values():
			output_val += num
		
		# Add up the mult vals then apply them.
		var multiplier = 1
		for num in mult_dict.values():
			output_val += num
		
		output_val *= multiplier
	
	return output_val
