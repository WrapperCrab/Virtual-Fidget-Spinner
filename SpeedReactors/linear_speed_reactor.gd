extends 'res://SpeedReactors/speed_reactor.gd'
#varies the wanted value with speed in a linear fashion with max and min limits

@export var minValue : float
@export var minValueSpeed : float
@export var maxValue : float
@export var maxValueSpeed : float

var slope : float

func _ready():
	super()
	slope = ((maxValue-minValue)/(maxValueSpeed-minValueSpeed))

func spin_speed_to_value(spinSpeed):
	var newValue
	if spinSpeed<minValueSpeed:
		newValue = minValue
	elif spinSpeed<maxValueSpeed:
		newValue = slope*(spinSpeed-maxValueSpeed)+maxValue
	else:
		newValue = maxValue
	return newValue

