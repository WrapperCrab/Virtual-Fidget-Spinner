extends "res://SpeedReactors/linear_speed_reactor.gd"

@onready var rumblePlayer = $'..'
func use_value(value):
	rumblePlayer.set_volume_db(value)
