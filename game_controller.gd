extends Node
var total_shrooms: int=0
func coin_collected(value: int):
    total_shrooms+=value
    Eq.shrooms+=1
    EventController.emit_signal("coin_collected", total_shrooms)
    Eq.emit_signal("eqChange")
