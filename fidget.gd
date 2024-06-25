extends Node2D

signal spinner_over

#set by speed_reactor children
var currentSaturation
var currentHueChangeSpeed


func _ready():
	set_modulate(Color.WHITE)
	
func _process(_delta):
	var currentSpinSpeed = get_spin_speed()
	if currentSpinSpeed>=%Spinner.maxSpeed:
		end_life()

	#update hue
	var newHue = fposmod(currentSpinSpeed*currentHueChangeSpeed,1.0)
	#update saturation
	var newSat = currentSaturation
	#update value
	var newVal = 1.0
	#set the color
	var newColor = Color.from_hsv(newHue,newSat,newVal)
	set_modulate(newColor)
	

func get_spin_speed():
	return abs(%Spinner.spinSpeed)

func end_life():
	spinner_over.emit()

	
