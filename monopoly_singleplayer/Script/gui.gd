extends CanvasLayer


func _on_button_button_down() -> void:
	get_parent().player_position += get_parent().los_number()
	var pos = get_parent().player_position
	get_parent().player_position %= 40
	get_parent().call_cells_functions()
	# FUNCTION START
	if pos != pos % 40:
		get_parent().money += 200
	# ^^^^^^^^^^^^^^

func next_player():
	var players_list = get_parent().get_parent().players_list
	$".".hide()
	players_list[players_list.find(get_parent()) - 1].get_node('Gui').show()
	print(players_list.find(get_parent()) - 1)
	get_parent().get_parent().get_node('now_player').text = 'Player: ' + str(1 + players_list.find(players_list[players_list.find(get_parent()) - 1]))


func _on_buy_pressed() -> void:
	var Board = get_node('/root/Main/Board')
	var player = get_parent()
	if player.money >= Board.cells[player.player_position].price:
		player.money -= Board.cells[player.player_position].price
		Board.cells[player.player_position].player_owner = player
		Board.cells[player.player_position].bildings = 1
	$buy_options.hide()
	$random.show()
	next_player()

func _on_no_buy_pressed() -> void:
	$buy_options.hide()
	$random.show()
	next_player()
