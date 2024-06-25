extends Sprite2D

signal explosion_done

func _ready():
	$ExplodeAnimation.animation_finished.connect(on_animation_finished)
	set_visible(false)

func explode():
	set_visible(true)
	$ExplodeAnimation.play('explode')
	$Sound.play()

func on_animation_finished(_animName):
	set_visible(false)
	explosion_done.emit()
