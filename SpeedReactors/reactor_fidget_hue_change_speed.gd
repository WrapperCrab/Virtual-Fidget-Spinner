extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var fidget = $'..'
func use_value(value):
	fidget.currentHueChangeSpeed = value
