extends Node2D

signal beep

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
	position.x = rng.randi_range(0, get_viewport().get_visible_rect().size.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if position.y >= get_viewport().get_visible_rect().size.y - 20 and count < BOUNCE_LIMIT:
		velocity *= -0.7
		scale /= 1.5
		count += 1
	
	if count == BOUNCE_LIMIT:
		queue_free()
		Score.lives -= 1
	
	position.y = position.y + delta * velocity.y
	velocity.y = velocity.y + delta * GRAVITY

func _on_button_button_down() -> void:
	beep.emit()
	Score.score += 2 ** count
	Score.count += 1
	queue_free()
