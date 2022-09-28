extends Node2D

func _ready():
	pass # Replace with function body.

func _on_Wheel_pressed():
	get_tree().change_scene("res://Games/Wheel of fortune.tscn")

func _on_Chuck_a_luck_pressed():
	get_tree().change_scene("res://Games/Chuck a luck.tscn")

func _on_Lottery_pressed():
	get_tree().change_scene("res://Games/Lottery.tscn")


func _on_Dropper_pressed():
	get_tree().change_scene("res://Games/Dropper.tscn")


func _on_Blackjack_pressed():
	get_tree().change_scene("res://Games/Blackjack.tscn")
