extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var background = $'..'
func use_value(value):
	var newColor = Color(value,value,value)
	background.set_color(newColor)
