extends Node

class_name Effect


# Shop data:

## The display name for the effect in the store.
var effect_name: String
## The icon used in the store to represent this effect.
var icon_path: String
## The cost of purchasing this effect.
var buy_cost: int
## The effect needed to be purchased before this is unlocked.
var prerequisite: Effect

# Default benefits:

## A value added to the base click value before any multipliers.
var click_base_mod: int
## A value multiplied to the click base value and the sum of its mods.
var click_mult_mod: int

# Other effects:

## The function to be called once during activation of the effect. No variables will be passed.
var activation_func: Callable
## The function to be called every physics_process loop. Delta will be passed.
var loop_func: Callable
## The function to be called once during deactivation of the effect. No variables will be passed.
var deactivation_func: Callable


## Initialize the class with the default values.
func _init(name: String, icon: String, cost: int, prereq: Effect=null,
		activation: Callable=noop, loop: Callable=noop, deactivation: Callable=noop) -> void:
	effect_name = name
	icon_path = icon
	prerequisite = prereq
	buy_cost = cost
	activation_func = activation
	loop_func = loop
	deactivation_func = deactivation

## Does nothing, used as a placeholder value.
func noop():
	pass
