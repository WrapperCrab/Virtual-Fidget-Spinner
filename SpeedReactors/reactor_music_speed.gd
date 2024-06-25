extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var musicPlayer = $'..'
func use_value(value):
	musicPlayer.set_pitch_scale(value)
