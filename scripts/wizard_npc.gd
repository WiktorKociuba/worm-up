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
        DialogController.emit_signal("displayDialog",dialogsWho[0],dialogs[0],0,whoIsThis)
        dialogDisplayed = true
    if questId == 0:
        questItemQuantity = Eq.strawberies
    elif questId == 1:
        questItemQuantity = Eq.shrooms
    if body is Player and questItemQuantity > 0 and QuestController.isQuestActive[questId]:
        DialogController.emit_signal("displayDialog",dialogsWho[dialogsWho.size()-1],dialogs[dialogs.size()-1],-2,whoIsThis) 
        if questId == 0:
            Eq.strawberies-=1
        elif questId == 1:
            Eq.shrooms-=1
        QuestController.emit_signal("deleteQuest",questId)
    
func displayNextDialog(who: int, id: int, orgid: int):
    if orgid == whoIsThis:
        if id+1 < dialogs.size()-1:
            DialogController.emit_signal("displayDialog",dialogsWho[id+1],dialogs[id+1],id+1,orgid)
        elif id == -2:
            DialogController.emit_signal("displayDialog",-1,"",-1,orgid)
            Eq.eqChange.emit()
        else:
            DialogController.emit_signal("displayDialog",-1,"",-1,orgid)
            QuestController.emit_signal("activateQuest",questId,questText)
            if whoIsThis == 3:
                QuestController.emit_signal("activateQuest",3,"Go to the trendsetter")
                QuestController.emit_signal("activateQuest",4,"Go to the hairdresser")
        
