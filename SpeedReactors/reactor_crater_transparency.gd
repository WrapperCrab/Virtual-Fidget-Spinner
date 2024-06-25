extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var crater = $'..'
func use_value(value):
	crater.self_modulate.a = value
