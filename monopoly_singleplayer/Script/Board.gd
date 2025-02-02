extends Node2D

const Cell = preload("res://Script/Cell.gd")
var Functions = preload("res://Script/Cells_functions.gd")
var size         # Vector2(x,y)
var cells
var lucky_cards     # []
var community_cards # []
var old_viewport = Vector2(0,0)
var texturess = {
	0:load('res://Texture/start.png'),
	1:load("res://Texture/brown.png"),
	2:load("res://Texture/cyan.png"),
	3:load("res://Texture/pink.png"),
	4:load("res://Texture/orange.png"),
	5:load("res://Texture/red.png"),
	6:load("res://Texture/yellow.png"),
	7:load("res://Texture/green.png"),
	8:load("res://Texture/blue.png"),
	9:load("res://Texture/dworzec.png"),
	10:load("res://Texture/szansa.png"),
	11:load("res://Texture/podatek.png"),
	12:load("res://Texture/kasa.png"),
	13:load('res://Texture/parking.png'),
	14:load("res://Texture/jail.png"),
	15:load('res://Texture/idz_do.png'),
	16:load("res://Texture/elek.png"),
	17:load("res://Texture/kran.png")
	}
var board_scale

func _ready() -> void:
	Functions = Functions.new()
	size = Vector2(11,11)
	cells = [
		Cell.new(false,0,[],0,'',Callable.create(Functions,'start')),
		Cell.new(true,60,[2,4,10,30,90,160,250],1,'A1',Callable.create(Functions,'street')),
		Cell.new(false,0,[],12,'Kasa społeczna',Callable.create(Functions,'community_chest')),
		Cell.new(true,60,[4,8,20,60,180,320,450],1,'A2',Callable.create(Functions,'street')),
		Cell.new(false,0,[],11,'Podatek',Callable.create(Functions,'tax1')),
		Cell.new(true,200,[25,50,100,200],9,'Metro 1',Callable.create(Functions,'train')),
		Cell.new(true,100,[6,12,30,90,270,400,550],2,'B1',Callable.create(Functions,'street')),
		Cell.new(false,0,[],10,'Szansa',Callable.create(Functions,'chance')),
		Cell.new(true,100,[6,12,30,90,270,400,550],2,'B2',Callable.create(Functions,'street')),
		Cell.new(true,120,[8,16,40,100,300,450,600],2,'B3',Callable.create(Functions,'street')),
		Cell.new(false,0,[],14,'',Callable.create(Functions,'prison')),
		Cell.new(true,140,[10,20,50,150,450,625,750],3,'C1',Callable.create(Functions,'street')),
		Cell.new(true,150,[],16,'Prąd',Callable.create(Functions,'power')),
		Cell.new(true,140,[10,20,50,150,450,625,750],3,'C2',Callable.create(Functions,'street')),
		Cell.new(true,160,[12,24,60,180,500,700,900],3,'C3',Callable.create(Functions,'street')),
		Cell.new(true,200,[25,50,100,200],9,'Metro 2',Callable.create(Functions,'train')),
		Cell.new(true,180,[14,28,70,200,550,750,950],4,'D1',Callable.create(Functions,'street')),
		Cell.new(false,0,[],12,'Kasa społeczna',Callable.create(Functions,'community_chest')),
		Cell.new(true,180,[14,28,70,200,550,750,950],4,'D2',Callable.create(Functions,'street')),
		Cell.new(true,200,[16,32,80,220,600,800,1000],4,'D3',Callable.create(Functions,'street')),
		Cell.new(false,0,[],13,'',Callable.create(Functions,'parking')),
		Cell.new(true,220,[18,36,90,250,700,875,1050],5,'F1',Callable.create(Functions,'street')),
		Cell.new(false,0,[],10,'Szansa',Callable.create(Functions,'chance')),
		Cell.new(true,220,[18,36,90,250,700,875,1050],5,'F2',Callable.create(Functions,'street')),
		Cell.new(true,240,[20,40,100,300,750,925,1100],5,'F3',Callable.create(Functions,'street')),
		Cell.new(true,200,[25,50,100,200],9,'Metro 3',Callable.create(Functions,'train')),
		Cell.new(true,260,[22,44,110,330,800,975,1150],6,'G1',Callable.create(Functions,'street')),
		Cell.new(true,260,[22,44,110,330,800,975,1150],6,'G2',Callable.create(Functions,'street')),
		Cell.new(true,150,[],17,'Woda',Callable.create(Functions,'water')),
		Cell.new(true,280,[24,48,120,360,850,1025,1200],6,'G3',Callable.create(Functions,'street')),
		Cell.new(false,0,[],15,'',Callable.create(Functions,'go_to_prison')),
		Cell.new(true,300,[26,52,130,390,900,1100,1275],7,'H1',Callable.create(Functions,'street')),
		Cell.new(true,300,[26,52,130,390,900,1100,1275],7,'H2',Callable.create(Functions,'street')),
		Cell.new(false,0,[],12,'Kasa społeczna',Callable.create(Functions,'community_chest')),
		Cell.new(true,320,[28,56,150,450,1000,1200,1400],7,'H3',Callable.create(Functions,'street')),
		Cell.new(true,200,[25,50,100,200],9,'Metro 4',Callable.create(Functions,'train')),
		Cell.new(false,0,[],10,'Szansa',Callable.create(Functions,'chance')),
		Cell.new(true,350,[35,70,175,500,1100,1300,1500],8,'I1',Callable.create(Functions,'street')),
		Cell.new(false,0,[],11,'Podatek',Callable.create(Functions,'tax2')),
		Cell.new(true,400,[50,100,200,600,1400,1700,2000],8,'I2',Callable.create(Functions,'street'))
	]

func display() -> void:
	old_viewport = get_viewport().size
	var children = get_children()
	for child in children:
		child.free()
	var rot = 0
	var iteration = 1
	var csize = size.x
	var offset = Vector2(0,0)
	var start_pos = Vector2(old_viewport.x/10*8,old_viewport.y/10*9)
	board_scale = 0.00019 * min(get_viewport().size.y,get_viewport().size.x)
	var distance
	var name_label_distace_up = 405 * board_scale
	for cell in cells:
		if (cells.find(cell)+1)%10 in [0,1]:
			distance = 452.5* board_scale
		else:
			distance = 405* board_scale
		
		var cell_node = Node2D.new()
		var name_label = Label.new()
		var cell_texture = Sprite2D.new()
		
		name_label.text = cell.cell_name
		name_label.scale = Vector2(board_scale*5,board_scale*5)
		var vector_to_left = -20 * name_label.get_total_character_count()*board_scale
		name_label.position = Vector2(vector_to_left,-name_label_distace_up/5*3)
		var theme = Theme.new()
		theme.set_color("font_color", "Label", Color(0, 0, 0))
		name_label.theme = theme
		
		cell_texture.texture = texturess[cell.color]
		cell_texture.scale = Vector2(board_scale,board_scale)
		cell_node.position = Vector2(start_pos.x + offset.x, start_pos.y + offset.y)
		
		cell_node.add_child(cell_texture)
		cell_node.add_child(name_label)
		cell_node.rotation = deg_to_rad(rot*90)
		add_child(cell_node)
		
		iteration += 1
		match rot: 
			0: 
				offset.x -= distance
			1:
				offset.y -= distance
			2:
				offset.x += distance
			3:
				offset.y += distance
		if iteration == csize:
			rot += 1
			if csize == size.x:
				csize = size.y
			else:
				csize = size.x 
			iteration = 1

func _process(delta: float) -> void:
	if old_viewport.x != get_viewport().size.x or old_viewport.y != get_viewport().size.y:
		display()
