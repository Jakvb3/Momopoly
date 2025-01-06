extends Node


func start(player):
	player.money += 200

func tax1(player):
	player.money -= 200
func tax2(player):
	player.money -= 100

func parking():
	pass

func street(player,bildings,player_owner,rent,price):
	if player_owner:
		player.money -= rent[bildings]
		player_owner.money += rent[bildings]
	else:
		ask_to_buy(player,price)

func train(player,player_train,player_owner,rent,price):
	if player_owner:
		player.money -= rent[player_train]
		player_owner.money += rent[player_train]
	else:
		ask_to_buy(player,price)

func chance(player):
	pass

func community_chest(player):
	pass

func prison(player):
	pass

func power(player,player_power_water,player_owner,price):
	if player_owner:
		var cost = los_number(player) * (5 if player_power_water == 1 else 10)
		player.money -= cost 
		player_owner.money += cost
	else:
		ask_to_buy(player,price)

func water(player,player_power_water,player_owner,price):
	if player_owner:
		var cost = los_number(player) * (5 if player_power_water == 1 else 10)
		player.money -= cost 
		player_owner.money += cost
	else:
		ask_to_buy(player,price)

func go_to_prison(player):
	pass


func ask_to_buy(player,price):
	var buy_button = Button.new()
	var no_buy_button = Button.new()
	var buy_text = Label.new()
	buy_text.text =  'Kwota: ' + str(price) + '$'
	buy_button.text = 'Kup'
	no_buy_button.text = 'Odrzuć'
	add_card(player)

func add_card(player):
	pass

func los_number(player):
	var random_number_1 = randi() % 7 + 1
	var random_number_2 = randi() % 7 + 1
	var random_number = random_number_1 + random_number_2
	return random_number
