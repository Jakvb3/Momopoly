extends Node

var ownable
var player_owner
var price
var bildings
var rent
var color
var cell_name
var call_back


func _init(ownable1: bool, price1: int, rent1: Array, color1: int, cell_name1: String, call_back1: Callable):
	ownable = ownable1
	price = price1
	rent = rent1
	color = color1
	cell_name = cell_name1
	call_back = call_back1

# call_back.bindv([player]).call()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
