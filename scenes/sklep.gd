extends Node2D
func _ready() -> void:
	$Area2D.monitoring = false
	$Area2D.monitorable = false
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		GameController.globalPos = body.position
		get_tree().change_scene_to_file("res://scenes/market.tscn")
func _on_timer_timeout() -> void:
	$Area2D.monitoring = true
	$Area2D.monitorable = true
