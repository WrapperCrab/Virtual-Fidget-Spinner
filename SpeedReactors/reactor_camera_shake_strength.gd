extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var camera = $'..'
func use_value(value):
	camera.set_shake_strength(value)
