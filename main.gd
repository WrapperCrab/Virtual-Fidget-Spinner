extends Node2D
#handles state changes using multiple nodes

enum States {SPINNER,EXPLODE,DIALOGUE}
var state = States.SPINNER

@export var fidgetsDestroyed : int = 0#Decides what dialogue is shown

func _ready():
	%Fidget.spinner_over.connect(on_fidget_too_fast)
	%Explosion.explosion_done.connect(on_explosion_done)
	%DialogueLabel.finished.connect(on_dialogue_finished)

func on_fidget_too_fast():
	#explode the fidget spinner
	state = States.EXPLODE
	fidgetsDestroyed+=1
	%Spinner.set_process(false)
	%Spinner.set_process_input(false)
	%Spinner.spinSpeed = 0.0
	#make us explode
	%Explosion.explode()
	#disappear
	%Fidget.set_visible(false)

func on_explosion_done():
	#do dialogue
	state = States.DIALOGUE
	var timer = get_tree().create_timer(3.0)
	await timer.timeout
	var dialogueIndex = fidgetsDestroyed-1
	%DialogueLabel.do_dialogue(dialogueIndex)
	
func on_dialogue_finished():
	#"Spawn" a new spinner
	state = States.SPINNER
	%Spinner.set_process(true)
	%Spinner.set_process_input(true)
	%Spinner.rotation = 0.0
	%Fidget.set_visible(true)
	var dialogueIndex = fidgetsDestroyed-1
	if dialogueIndex == 3:
		$FunnyNoises/Clown.play()
	else:
		$FunnyNoises/NewSpinner.play()


