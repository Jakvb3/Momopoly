extends Node2D

var money = 0
var player_train = 0
var player_power_water = 0
var player_position = 0

func _ready() -> void:
	$Gui.hide()
	if is_multiplayer_authority():
		$Gui.show()
		preload("res://Script/Multiplayer_main.gd").new().hide_buttons()


func _process(delta: float) -> void:
	if is_multiplayer_authority():
		$"Gui/Money".text = str(money)

func _enter_tree():
	set_multiplayer_authority(name.to_int())
