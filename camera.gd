extends Camera2D

@onready var noise = FastNoiseLite.new()
var noiseLocation : float = 0.0
@onready var rng = RandomNumberGenerator.new()

@export var shakeSpeed = 15.0
var shakeStrength = 0.0

func _ready():
	rng.randomize()
	noise.set_noise_type(noise.TYPE_SIMPLEX)
	noise.seed = rng.randi()
	noise.frequency = 0.5
	
func _process(delta):
	var shakeOffset = get_noise_offset(delta,shakeSpeed,shakeStrength)
	self.set_offset(shakeOffset)

func get_noise_offset(delta,speed,strength):
	noiseLocation += delta*speed
	return Vector2(
		noise.get_noise_2d(1,noiseLocation)*strength,
		noise.get_noise_2d(100,noiseLocation)*strength)

func set_shake_strength(newStrength):
	shakeStrength = newStrength
