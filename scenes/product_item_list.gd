extends ItemList

func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
    if index == 1:
        $"../JP2".visible = true
        $"../JP2/Area2D/Kremówka".visible = true
        visible = false
