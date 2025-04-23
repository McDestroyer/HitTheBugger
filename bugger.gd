extends CharacterBody2D

@onready
var system = get_parent()

@onready
var box_size: Vector2 = $BuggerShape.get_shape().get_rect().size
#var move_area: Rect2 = Rect2(0, 0, 1920, 1080)
var move_area: Vector2i = Vector2i()

var default_screen_size: Vector2i = Vector2i(1920, 1080)

@export
var delay_low: int = 300
@export
var delay_high: int = 2000

var speed_low: int = int(move_area.length() / 10.0)
var speed_high: int = int(move_area.length() / 3.0)

var current_speed: int = 0

var goal: Vector2 = position
var goal_direction: Vector2 = Vector2()

var arrived: bool = false
var last_time: int = Time.get_ticks_msec()
var delay_time: int = randi_range(delay_low, delay_high)


func _ready() -> void:
	# Set up 
	get_window().size_changed.connect(window_fix)
	window_fix()

func _physics_process(delta):
	velocity = Vector2.ZERO
	# If it has arrived at where it was going...
	if position == goal:
		# ...and this is the first loop in which it has done so...
		if arrived == false:
			# ...toggle the flag indicating such, save the time, and set a timer
			# for the next movement.
			arrived = true
			last_time = Time.get_ticks_msec()
			delay_time = randi_range(delay_low, delay_high)
		
		# ...and this isn't the first loop but it has waited the delay time...
		elif Time.get_ticks_msec() >= last_time + delay_time:
			# ...generate a new position tomove to and reset the flag.
			generate_goal()
			arrived = false
	
	# If it hasn't arrived yet, move towards the goal.
	else:
		position.x = move_toward(position.x, goal.x, current_speed * delta * abs(goal_direction.x))
		position.y = move_toward(position.y, goal.y, current_speed * delta * abs(goal_direction.y))
		
		move_and_slide()

## Generates a new goal position and speed with which to move towards it.
func generate_goal():
	# Generate the position to move to.
	goal.x = randi_range(
		box_size.x/2,
		move_area.x - box_size.x/2
		)
	goal.y = randi_range(
		box_size.y/2,
		move_area.y - box_size.y/2
		)
	
	# Find the unit vector toward the goal
	goal_direction = (goal - position).normalized()
	
	# Pick a random speed from between the bars.
	current_speed = randi_range(speed_low, speed_high)

## Update window size-based variables. Connected to the Window.size_changed signal 
func window_fix():
	move_area = get_window().size
	
	# Reset the speed bars just in case the window size changed.
	speed_low = int(move_area.length() / 10.0)
	speed_high = int(move_area.length() / 3.0)

	scale = Vector2(1, 1) * (move_area.length() / default_screen_size.length())


func _on_hit_box_pressed() -> void:
	system.hit(system.HitTypes.BASIC)

func _on_crit_box_pressed() -> void:
	system.hit(system.HitTypes.CRITICAL)
