class_name Player extends CharacterBody2D

@export var headItems: Array[Sprite2D] = []
@export var neckItems: Array[Sprite2D] = []
@export var topItems: Array[Sprite2D] = []
@export var bottomItems: Array[Sprite2D] = []
@export var enableCamera: bool = true
@export var canWalk: bool = true
@export var ifŻółty: bool = false
@export var npcIcons: Array[TextureRect] = []

var dialogId: int
var dialogWho: int
var disableMovement: bool = false

const SPEED = 400.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
    setupClothes()
    if not enableCamera:
        $Camera2D.visible = false
    Clothes.clothesChanged.connect(setupClothes)
    DialogController.displayDialog.connect(displayNewDialog)
    
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

    move_and_slide()

func _process(delta: float) -> void:
    if ifŻółty:
        $"żółty".visible = true
        $normalny.visible = false
    else:
        $"żółty".visible = false
        $normalny.visible = true

func _on_area_2d_body_entered(body: Node2D) -> void:
    pass # Replace with function body.

func displayNewDialog(who: int,text: String, id: int):
    if id == -1:
        $UI/DialogUI.visible = false
        disableMovement = false
        return
    if id == 0:
        disableMovement = true
        $UI/DialogUI.visible = true
    $UI/DialogUI/DialogBox/DialogText.text = text
    for icon in npcIcons:
        icon.visible = false
    npcIcons[who].visible = true
    dialogWho = who
    dialogId = id
    
func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton and event.pressed:
        print("hreredw")
        DialogController.emit_signal("nextDialog", dialogWho, dialogId)

func _on_button_pressed() -> void:
    get_tree().change_scene_to_file("res://scenes/main.tscn")
