extends Node2D

var wheel = preload("res://wheel.tscn")
var engine = preload("res://engine.tscn")
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Engine.time_scale = 0.5
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CanvasLayer/Label.text = "Score: " + str(Score.score)
	$CanvasLayer/Label2.text = "Lives: " + str(Score.lives)
	if Score.lives == 0:
		$CanvasLayer/Label3.visible = true
		get_tree().paused = true


func _on_timer_timeout() -> void:
	var rand_num = rng.randi_range(1, 10)
	$Timer.wait_time = rand_num / (1.0 + sqrt(Score.score))  # Makes the game faster as score increases
	if rand_num % 2 == 0:
		add_child(wheel.instantiate())
	else:
		add_child(engine.instantiate())
		


func _on_timer_timeout2() -> void:
	$CanvasLayer/SungryNDialogue.queue_free()
