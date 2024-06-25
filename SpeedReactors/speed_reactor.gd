extends Node
#uses the speed of the spinner every frame to get a value and do something with it

func _ready():
	use_value(spin_speed_to_value(0.0))

func _process(_delta):
	var currentSpinSpeed = get_spin_speed()
	var newValue = spin_speed_to_value(currentSpinSpeed)
	use_value(newValue)

func use_value(_value):#to be overwritten
	pass

func spin_speed_to_value(_spinSpeed):#to be overwritten
	return 0

func get_spin_speed():
	return abs(%Spinner.spinSpeed)
