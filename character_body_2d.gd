extends CharacterBody2D

@export var headItems: Array[Sprite2D] = []
@export var neckItems: Array[Sprite2D] = []
@export var topItems: Array[Sprite2D] = []
@export var bottomItems: Array[Sprite2D] = []

const SPEED = 300.0

func _ready() -> void:
    setupClothes()
    Clothes.clothesChanged.connect(setupClothes)

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
    if headItems.size() > Clothes.head:
        headItems[Clothes.head].visible = true
    if neckItems.size() > Clothes.neck:
        neckItems[Clothes.neck].visible = true
    if topItems.size() > Clothes.top:
        topItems[Clothes.top].visible = true
    if bottomItems.size() > Clothes.bottom:
        print(Clothes.bottom)
        bottomItems[Clothes.bottom].visible = true

func _physics_process(delta: float) -> void:
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
