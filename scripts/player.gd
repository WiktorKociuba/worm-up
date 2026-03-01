class_name Player extends CharacterBody2D

@export var headItems: Array[Sprite2D] = []
@export var neckItems: Array[Sprite2D] = []
@export var topItems: Array[Sprite2D] = []
@export var bottomItems: Array[Sprite2D] = []
@export var enableCamera: bool = true
@export var canWalk: bool = true
@export var ifŻółty: bool = false
@export var npcIcons: Array[TextureRect] = []


@export var sfx_jump:AudioStream
@export var sfx_footsteps:AudioStream

var dialogId: int
var dialogWho: int = -1
var gorgid: int = -1
var disableMovement: bool = false
var quests = {}

const SPEED = 4000.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
    if get_tree().current_scene.scene_file_path == "res://scenes/main.tscn":
        position = GameController.globalPos
    setupClothes()
    if not enableCamera:
        $Camera2D.visible = false
    Clothes.clothesChanged.connect(setupClothes)
    DialogController.displayDialog.connect(displayNewDialog)
    QuestController.activateQuest.connect(addQuest)
    QuestController.deleteQuest.connect(removeQuest)
    Eq.eqChange.connect(updateEq)
    load_sfx(sfx_footsteps)
    updateEq()
    for i in range(5):
        if QuestController.isQuestActive[i] and not QuestController.isQuestCompleted[i]:
            addQuest(i,QuestController.questTexts[i])
    
func setupClothes() -> void:
    for item in headItems:
        if item != null:
            item.visible = false
    for item in neckItems:
        if item != null:
            item.visible = false
    for item in topItems:
        if item != null:
            item.visible = false
    for item in bottomItems:
        if item != null:
            item.visible = false
    if headItems.size() > Clothes.head and not Clothes.head == -1:
        headItems[Clothes.head].visible = true
    if neckItems.size() > Clothes.neck and not Clothes.neck == -1:
        neckItems[Clothes.neck].visible = true
    if topItems.size() > Clothes.top and not Clothes.top == -1:
        topItems[Clothes.top].visible = true
    if bottomItems.size() > Clothes.bottom and not Clothes.bottom == -1:
        print(Clothes.bottom)
        bottomItems[Clothes.bottom].visible = true

func _physics_process(delta: float) -> void:
    if Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") or Input.is_action_just_pressed("up") and not $sfx.playing:
        $sfx.play()
    if Input.is_action_just_released("down") or Input.is_action_just_released("left") or Input.is_action_just_released("right") or Input.is_action_just_released("up") and $sfx.playing:
        $sfx.stop()
    if disableMovement:
        return
    if not canWalk:
        return
    var direction := Input.get_axis("left", "right")
    if direction:
        velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
    var directionY := Input.get_axis("up","down")
    if directionY:
        velocity.y = directionY * SPEED
    else:
        velocity.y = move_toward(velocity.y, 0, SPEED)
    if velocity.length() > 0:
        var flip = velocity.x < 0
        $normalny.flip_h = flip
        $"żółty".flip_h = flip
        for child in neckItems:
            if child != null:
                child.flip_h = flip
        for child in topItems:
            if child != null:
                child.flip_h = flip
        for child in bottomItems:
            if child != null:
                child.flip_h = flip
    move_and_slide()


func _process(delta: float) -> void:
    if ifŻółty:
        $"żółty".visible = true
        $normalny.visible = false
    else:
        $"żółty".visible = false
        $normalny.visible = true
    for i in range(5):
        if QuestController.isQuestCompleted[i] == false:
            return
    print("completed")
    for i in range(5):
        quests[i].queue_free()
    addQuest(0,"Find the stage!")
func _on_area_2d_body_entered(body: Node2D) -> void:
    pass # Replace with function body.

func displayNewDialog(who: int,text: String, id: int, orgid:int):
    print(text)
    gorgid = orgid
    if id == -1:
        $UI/DialogUI.visible = false
        gorgid = -1
        disableMovement = false
        dialogId = id
        dialogWho = -1
        return
    if id == 0 or id == -2:
        disableMovement = true
        $UI/DialogUI.visible = true
    $UI/DialogUI/DialogBox/DialogText.text = text
    for icon in npcIcons:
        icon.visible = false
    npcIcons[who].visible = true
    dialogWho = who
    dialogId = id
    
func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed and dialogWho > -1:
        DialogController.emit_signal("nextDialog", dialogWho, dialogId, gorgid)

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")
    
func addQuest(id: int, text: String):
    var questLabel = Label.new()
    QuestController.questTexts[id] = text
    questLabel.text = text
    $UI/QuestUI/TextureRect/VBoxContainer.add_child(questLabel)
    quests[id] = questLabel
    QuestController.isQuestActive[id] = true

func removeQuest(id:int):
    if QuestController.isQuestCompleted[id] == true:
        return
    QuestController.isQuestCompleted[id] = true
    quests[id].queue_free()
    for i in range(5):
        if i == 2:
            continue
        if QuestController.isQuestCompleted[i] == false:
            return
    quests[2].queue_free()
    addQuest(0,"Find the stage!")

func updateEq():
    $UI/EqUI/Strawberry/StrawLabel.text = str(Eq.strawberies)
    $UI/EqUI/Shroom/ShroomLabel.text = str(Eq.shrooms)

func load_sfx(sfx_to_load):
    if $sfx.stream != sfx_to_load:
        $sfx.stop()
        $sfx.stream = sfx_to_load
