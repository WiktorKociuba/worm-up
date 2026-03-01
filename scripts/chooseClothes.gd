extends Node2D




func _on_head_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		Clothes.head = -1
	else:
		Clothes.head = index-1
	Clothes.clothesChanged.emit()


func _on_neck_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		Clothes.neck = -1
	else:
		Clothes.neck = index-1
	Clothes.clothesChanged.emit()

func _on_top_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		Clothes.top = -1
	else:
		Clothes.top = index-1
	Clothes.clothesChanged.emit()

func _on_bottom_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	if index == 0:
		Clothes.bottom = -1
	else:
		Clothes.bottom = index-1
	Clothes.clothesChanged.emit()


func _on_choose_clothes_type_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	$NeckItemList.visible = false
	$TopItemList.visible = false
	$BottomItemList.visible = false
	if index == 0:
		$NeckItemList.visible = true
	if index == 1:
		$TopItemList.visible = true
	if index == 2:
		$BottomItemList.visible = true
	


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")
