extends Node2D
func play():
	$AnimationPlayer.play("new_animation")

func _on_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
