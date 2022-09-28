extends Node2D

onready var player = get_node("/root/Player")

var packs = ["common", "rare", "super"]
var cost = ["100", "1000", "10000"]
var pack_numbers = [0,0,0]

func _ready():
	pass # Replace with function body.

func _process(delta):
	$Control/Money.text = "Money: " + str(player.money)

func _on_Go_Back_pressed():
	get_tree().change_scene("res://Main.tscn")

