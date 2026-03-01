extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")

func _on_head_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    Clothes.head = index
    Clothes.clothesChanged.emit()
