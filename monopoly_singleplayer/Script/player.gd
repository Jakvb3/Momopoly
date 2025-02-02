extends Node2D


var money = 2000
var player_train = 0
var player_power_water = 0
var player_position = 0
var textures = [load('res://Texture/player_icon/own1.png'),
				load('res://Texture/player_icon/own2.png'),
				load('res://Texture/player_icon/own3.png'),
				load('res://Texture/player_icon/own4.png')]

func _ready() -> void:
	$Gui/buy_options.hide()
	$Gui.hide()

func _process(delta: float) -> void:
	$"Gui/Money".text = str(money) + '$'
	$Gui.offset = Vector2(get_viewport().size.x/20,get_viewport().size.y/10*9)
	$Gui/buy_options.position = Vector2($Gui/Sometext.position.x ,$Gui/Sometext.position.y - 80)
	var players_list = get_parent().players_list
	$pawn.texture = textures[players_list.find(self)]
	var Board = get_node('/root/Main/Board')
	$pawn.scale = Vector2(Board.board_scale*1.5,Board.board_scale*1.5)
	$pawn.position = Board.get_child(player_position).position
	$Gui.scale = Vector2(Board.board_scale*7.5,Board.board_scale*7.5)
	if Board.visible:
		$pawn.show()
	else:
		$pawn.hide()

func los_number(): 
	var random_number_1 = randi() % 6 + 1
	var random_number_2 = randi() % 6 + 1
	var random_number = random_number_1 + random_number_2
	return random_number

func call_cells_functions():
	var Board = get_node('/root/Main/Board')
	var cell_return_next_player_call = Board.cells[player_position].call_back.call(self,Board.cells[player_position])
	print(Board.cells[player_position].cell_name)
	if cell_return_next_player_call:
		$Gui.next_player()
