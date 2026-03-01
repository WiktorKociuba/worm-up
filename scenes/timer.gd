extends Timer

var timer = Timer.new()

func time():
	timer.wait_time = 2.3
	timer.one_shot = true
	add_child(timer)
	timer.start()
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
