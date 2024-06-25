extends Sprite2D

#how much it slows down when not being spun
@export var deceleration : float = 2.0
#keyboard controls
@export var acceleration : float = 3.0
var opposingAcceleration : float = 20.0#acceleration when pressing dir opposite of current spin speed

var spinSpeed : float = 0.0 #negative means counter-clockwise
var maxSpeed : float = 250.0

@export var maxMouseSpeed : float = 5.0

#store mouse average movement while click held
var mouseStartPos : Vector2
var mouseEndPos : Vector2
var mouseStartTime : int
var mouseEndTime : int

func _input(event):#handle mouse input 
	if event is InputEventMouseButton:
		if event.button_index==MOUSE_BUTTON_LEFT:
			if event.pressed:
				#start storing mouse motion
				mouseStartPos = event.position
				mouseStartTime = Time.get_ticks_usec()
			else:
				#the player has let go of left click
				#use the stored velocity
				mouseEndPos = event.position
				mouseEndTime = Time.get_ticks_usec()
				add_mouse_velocity_to_spin(mouseStartPos,mouseEndPos,mouseStartTime,mouseEndTime)
				#reset mouse path info
				mouseStartPos = Vector2.ZERO
				mouseEndPos = Vector2.ZERO
				mouseStartTime = 0
				mouseEndTime = 0
func add_mouse_velocity_to_spin(startPos,endPos,startTime,endTime):
	var fidgetPos = self.transform.origin
	#find angle change relative to fidget
	var startPosRelFidget = startPos-fidgetPos
	var endPosRelFidget = endPos-fidgetPos
	var angleChange = atan2(startPosRelFidget.y,startPosRelFidget.x)-atan2(endPosRelFidget.y,endPosRelFidget.x)
	angleChange = fposmod(angleChange,2*PI)
	if angleChange>PI:
		angleChange-=2*PI
	#find the duration of the mouse motion
	var duration = float(endTime-startTime)/1000000.0 #(microseconds to seconds)
	#find rotation speed to add to spinner
	var addedSpeed = -angleChange/duration #negative cuz clockwise is positive in editor
	if addedSpeed>maxMouseSpeed:
		addedSpeed = maxMouseSpeed
	elif addedSpeed<-maxMouseSpeed:
		addedSpeed = -maxMouseSpeed
	spinSpeed+=addedSpeed

func _process(delta):
	var accelerationDir = Input.get_axis('ui_left','ui_right')
	if accelerationDir<-0.2:
		if spinSpeed>0:
			spinSpeed-=opposingAcceleration*delta
		else:
			spinSpeed-=acceleration*delta
		spinSpeed=max(-maxSpeed,spinSpeed)
	elif accelerationDir>0.2:
		if spinSpeed<0:
			spinSpeed+=opposingAcceleration*delta
		else:
			spinSpeed+=acceleration*delta
		spinSpeed=min(maxSpeed,spinSpeed)
	else:
		#decelerate
		if spinSpeed>0:
			spinSpeed-=deceleration*delta
		else:
			spinSpeed+=deceleration*delta
		if abs(spinSpeed)<0.1:
			spinSpeed = 0
	self.rotation+=spinSpeed*delta


