extends Node


func start(player,Board):
	return true # function in gui.gd

func tax1(player,Board):
	player.money -= 200
	return true

func tax2(player,Board):
	player.money -= 100
	return true

func parking(player,Board):
	return true

func street(player,Board):
	if Board.player_owner:
		player.money -= Board.rent[Board.bildings]
		Board.player_owner.money += Board.rent[Board.bildings]
	else:
		ask_to_buy(player,Board.price)
	return false

func train(player,Board):
	if Board.player_owner:
		player.money -= Board.rent[player.player_train]
		Board.player_owner.money += Board.rent[player.player_train]
	else:
		ask_to_buy(player,Board.price)
	return false

func chance(player,Board):
	return true

func community_chest(player,Board):
	return true

func prison(player,Board):
	return true

func power(player,Board):
	if Board.player_owner:
		var cost = los_number() * (10 if player.player_power_water == 1 else 5)
		player.money -= cost 
		Board.player_owner.money += cost
	else:
		ask_to_buy(player,Board.price)
	return false

func water(player,Board):
	if Board.player_owner:
		var cost = los_number() * (10 if player.player_power_water == 2 else 5)
		player.money -= cost 
		Board.player_owner.money += cost
	else:
		ask_to_buy(player,Board.price)
	return false

func go_to_prison(player,Board):
	return true

func ask_to_buy(player,price):
	player.get_node('Gui/random').hide()
	player.get_node('Gui/buy_options').show()
	player.get_node('Gui/buy_options/buy_text').text = 'Cena: ' + str(price)

func add_card(player):
	pass

func los_number(): 
	var random_number_1 = randi() % 7 + 1
	var random_number_2 = randi() % 7 + 1
	var random_number = random_number_1 + random_number_2
	return random_number
