extends Node2D


var peer = ENetMultiplayerPeer.new()
@export var player_scean: PackedScene


func _on_host_pressed() -> void:
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()

func _add_player(id = 1):
	var player = player_scean.instantiate()
	player.name = str(id)
	call_deferred("add_child", player)


func _on_join_pressed() -> void:
	peer.create_client("localhost", 135)
	multiplayer.multiplayer_peer = peer
	
func hide_buttons():
	$Host.hide()
	$Join.hide()
