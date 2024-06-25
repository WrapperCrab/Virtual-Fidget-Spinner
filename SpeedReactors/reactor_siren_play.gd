extends "res://SpeedReactors/speed_reactor.gd"

@onready var siren = $'..'
@onready var sirenColor = $'../SirenColor'

@export var minSirenSpeed : float = 160
@export var timeBetweenSirens : float = 1.2
@export var minFastSirenSpeed : float = 220
@export var fastTimeBetweenSirens : float = 0.6

var timeSinceSiren = 0.0

enum SirenStates {NONE,SLOW,FAST}

func _process(delta):
	super(delta)
	timeSinceSiren+=delta

func use_value(value):
	var neededTime
	match value:
		SirenStates.SLOW:
			neededTime = timeBetweenSirens
		SirenStates.FAST:
			neededTime = fastTimeBetweenSirens
		SirenStates.NONE:
			return
	if timeSinceSiren>neededTime:
		siren.play()
		sirenColor.flash()
		timeSinceSiren=0.0

func spin_speed_to_value(spinSpeed):
	if spinSpeed<minSirenSpeed:
		return SirenStates.NONE
	elif spinSpeed<minFastSirenSpeed:
		return SirenStates.SLOW
	return SirenStates.FAST
