extends Label

signal finished

@export var dialogues : Array[Dialogue]
@export var messageDuration : float = 3.0
@export var betweenMessageDuration : float = 1.5

func _ready():
	self.text = ""

func do_dialogue(dialogueIndex):#plays all the messages in order
	var fidgetsDestroyed = dialogueIndex+1
	var numDialogues=dialogues.size()
	var indexToUse = dialogueIndex if dialogueIndex<numDialogues else numDialogues-1
	for message in dialogues[indexToUse].strings:
		self.text = ""
		var timer = get_tree().create_timer(betweenMessageDuration)
		await timer.timeout
		if message.contains("%s"):
			self.text = message%fidgetsDestroyed
		else:
			self.text = message
		timer = get_tree().create_timer(messageDuration)
		await timer.timeout
	self.text = ""
	finished.emit()
