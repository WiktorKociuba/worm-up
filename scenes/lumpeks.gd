extends Node2D


func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player:
        GameController.globalPos = body.position
        QuestController.deleteQuest.emit(3)
        get_tree().change_scene_to_file("res://scenes/wardrobe.tscn")
        
        

func _ready() -> void:
    $Area2D.monitoring = false
    $Area2D.monitorable = false
func _on_timer_timeout() -> void:
    $Area2D.monitoring = true
    $Area2D.monitorable = true
