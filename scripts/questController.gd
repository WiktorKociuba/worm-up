extends Node
var questTexts = {
    0: "",
    1: "",
    2: ""
}
var isQuestCompleted = {
    0: false,
    1: false,
    2: false
}
var isQuestActive = {
    0: false,
    1: false,
    2: false
}
#ids
#0-bboy
#1-wizzard
signal activateQuest(id: int, text: String)
signal deleteQuest(id:int)
