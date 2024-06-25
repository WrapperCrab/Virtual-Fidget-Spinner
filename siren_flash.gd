extends ColorRect

@export var maxAlpha : float = 0.6
@export var timeToShow : float = 0.2
@export var timeToHide : float = 0.4

var flashing = false

func flash():
	#become visible, then return to being invisible
	flashing = true
	var tween = get_tree().create_tween()
	tween.tween_property(self,"color:a",maxAlpha,timeToShow)
	tween.tween_property(self,"color:a",0,timeToHide)
	tween.tween_callback(on_flash_end)

func on_flash_end():
	flashing = false
	
func is_flashing():
	return flashing
