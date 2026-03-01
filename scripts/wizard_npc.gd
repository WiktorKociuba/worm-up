class_name wizard extends CharacterBody2D

@export var dialogs: Array[String] = []
@export var dialogsWho: Array[int] = []
@export var questId: int
@export var questText: String
@export var whoIsThis: int
var dialogDisplayed: bool = false
var questItemQuantity: int = 0
func _ready() -> void:
    DialogController.nextDialog.connect(displayNextDialog)

func _on_area_2d_body_entered(body: Node2D) -> void:
    if body is Player and not dialogDisplayed and not QuestController.isQuestActive[questId]:
        DialogController.emit_signal("displayDialog",dialogsWho[0],dialogs[0],0)
        dialogDisplayed = true
    if questId == 0:
        questItemQuantity = Eq.strawberies
    elif questId == 1:
        questItemQuantity = Eq.shrooms
    if body is Player and questItemQuantity > 0 and QuestController.isQuestActive[questId]:
        DialogController.emit_signal("displayDialog",dialogsWho[dialogsWho.size()-1],dialogs[dialogs.size()-1],-2) 
        if questId == 0:
            Eq.strawberies-=1
        elif questId == 1:
            Eq.shrooms-=1
        QuestController.emit_signal("deleteQuest",questId)
    
func displayNextDialog(who: int, id: int):
    if who == whoIsThis or who == 0 and id != -1:
        if id+1 < dialogs.size()-1:
            DialogController.emit_signal("displayDialog",dialogsWho[id+1],dialogs[id+1],id+1)
        elif id == -2:
            DialogController.emit_signal("displayDialog",-1,"",-1)
            Eq.eqChange.emit()
        else:
            DialogController.emit_signal("displayDialog",-1,"",-1)
            QuestController.emit_signal("activateQuest",questId,questText)
        
