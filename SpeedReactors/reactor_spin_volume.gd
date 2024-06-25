extends 'res://SpeedReactors/linear_speed_reactor.gd'

@onready var spinPlayer = $'..'

func use_value(value):
	spinPlayer.set_volume_db(value)
