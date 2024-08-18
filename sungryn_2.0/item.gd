extends TextureButton

#class_name Item

# Add gravity and bounce limit
const GRAVITY = 1000
const BOUNCE_LIMIT = 5

# Velocity
var velocity = Vector2(0, 0)
var rng = RandomNumberGenerator.new()
var count = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.y = 0
	position.x = rng.randi_range(0, get_window().size.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if position.y >= get_window().size.y - 20 and count < BOUNCE_LIMIT:
		velocity *= -0.7
		scale /= 1.5
		position.x += 130 * scale.x
		position.y -= 130 * scale.y
		count += 1
	
	if count == BOUNCE_LIMIT:
		queue_free()
		Score.lives -= 1
	
	position.y = position.y + delta * velocity.y
	velocity.y = velocity.y + delta * GRAVITY

func _pressed() -> void:
	Score.score += (count + 1)
	queue_free()
