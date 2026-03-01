extends Node
var questTexts = {
    0: "",
    1: "",
    2: "",
    3: "",
    4: ""
}
var isQuestCompleted = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false
}
var isQuestActive = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false
}
#ids
#0-bboy
#1-wizzard
signal activateQuest(id: int, text: String)
signal deleteQuest(id:int)
