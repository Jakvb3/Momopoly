extends Node2D

var players_list = []
var player = preload("res://Scean/Player.tscn")
var game_start = false
func _ready() -> void:
	$Board.hide()
	$start.hide()

func _process(delta: float) -> void:
	var board_scale = get_node('/root/Main/Board').board_scale
	if board_scale:
		board_scale *= 10
	if $start.hidden:
		$start.position = Vector2(get_viewport().size.x/2 - $start.size.x/2,get_viewport().size.y/2)
		if board_scale:
			$start.scale = Vector2(board_scale,board_scale)
	if $buttons.hidden:
		if board_scale:
			$buttons/Player_num.scale = Vector2(board_scale,board_scale)
		$buttons/Player_num.position = Vector2(get_viewport().size.x/2 - $buttons/Player_num/text.size.x/2 ,get_viewport().size.y/3)
	$now_player.position = Vector2(get_viewport().size.x/20,get_viewport().size.y/10*7.25)
	
	
	if game_start:
		for i in players_list:
			if i.money < 0:
				pass
				# end game for that player
		$now_player.scale = Vector2(board_scale,board_scale)
		var move = 1
		for i in players_list:
			var icon = get_node(str(1 + players_list.find(i)))
			var label_text = get_node(str(1 + players_list.find(i)) + 'money')
			label_text.position = Vector2(get_viewport().size.x*1.5/20,get_viewport().size.y/10*move-10)
			label_text.scale = Vector2(board_scale,board_scale)
			label_text.text = str(i.money) + '$\n'
			icon.position = Vector2(get_viewport().size.x/20,get_viewport().size.y/10*move)
			icon.scale = Vector2(board_scale/3,board_scale/3)
			move += 0.75



func _on_start_pressed() -> void:
	$Board.show()
	$start.hide()
	players_list[0].get_node('Gui').show()
	$now_player.text = 'Player: 1'
	game_start = true
	for i in players_list:
		var icon = Sprite2D.new()
		var label_text = Label.new()
		label_text.name = str(1 + players_list.find(i)) + 'money'
		icon.name = str(players_list.find(i) + 1)
		icon.texture = load(str('res://Texture/player_icon/plr', str(players_list.find(i)+1) ,'.png'))
		add_child(icon)
		add_child(label_text)


func _on_2_pressed() -> void:
	number_of_player(2)
func _on_3_pressed() -> void:
	number_of_player(3)
func _on_4_pressed() -> void:
	number_of_player(4)

func number_of_player(a: int):
	$buttons.hide()
	$start.show()
	for i in range(a):
		add_child(player.instantiate())
		players_list.append(get_child(-1))
	print(players_list)
