extends Node
var birthdayQuestCompleted: bool = false
var wizardQuestCompleted: bool = false
var birthdayQuestActive: bool = false
var wizardQuestActive: bool = false
var isQuestCompleted = {
    0: false,
    1: false
}
var isQuestActive = {
    0: false,
    1: false
}
#ids
#0-bboy
#1-wizzard
signal activateQuest(id: int, text: String)
signal deleteQuest(id:int)
