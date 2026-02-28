extends Sprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass



func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
    if event is InputEventMouseButton and event.pressed:
        $"Area2D/Kremówka".visible = false
        $barka.play()
        $"../Player".ifŻółty = true
        $Timer.start(5.3)

func _on_timer_timeout() -> void:
    $"../ProductItemList".visible = true
    visible = false
    $"../Player".ifŻółty = false
