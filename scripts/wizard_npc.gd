class_name wizard extends CharacterBody2D

@export var dialogs: Array[String] = []
@export var dialogsWho: Array[int] = []
var dialogDisplayed: bool = false
func _ready() -> void:
    DialogController.nextDialog.connect(displayNextDialog)

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player and not dialogDisplayed:
        DialogController.emit_signal("displayDialog",dialogsWho[0],dialogs[0],0)
        dialogDisplayed = true
    
func displayNextDialog(who: int, id: int):
    if id+1 < dialogs.size():
        DialogController.emit_signal("displayDialog",dialogsWho[id+1],dialogs[id+1],id+1)
    else:
        DialogController.emit_signal("displayDialog",-1,"",-1)
