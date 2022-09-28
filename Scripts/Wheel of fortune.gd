extends Node2D

onready var player = get_node("/root/Player") 

func _ready():
	pass # Replace with function body.

#update winner
func winner(node):
	$Control/Label.text = node.get_node("Label").text

func _process(delta):
	$Control/Money.text = "Money: " + str(player.money)

func _on_Spin_pressed():
	$Wheel.spin()

func _on_Go_back_pressed():
	get_tree().change_scene("res://Main.tscn")
