extends Node2D

onready var card = preload("res://Game Scenes/Blackjack/Card.tscn")
onready var player_hand = get_node("Control/VBoxContainer/HBoxContainer/VBoxContainer/player_hand")

var game_started = false

func _ready():
	randomize()

func get_rand_card():
	return randi() % 13 + 1

func load_card_img(path):
	var new_card = card.instance()
	new_card.texture = load(path)
	player_hand.add_child(new_card)


func get_card_img(card_num):
	var img_name = ""
	print(card_num)
	if card_num > 10 or card_num == 1:
		if card_num == 11:
			img_name = "J"
		elif card_num == 12:
			img_name = "Q"
		elif card_num == 13:
			img_name = "K"
		elif card_num == 1:
			img_name = "A"
		else:
			print("ERROR")
	else:
		img_name = str(card_num)
	load_card_img("res://Assets/Cards/" + img_name + ".png")

func draw_card(is_player):
	if is_player == true:
		var rand_card = get_rand_card()
		get_card_img(rand_card)

func start():
	if game_started == false:
		draw_card(true)
		game_started = true

func _on_Start_pressed():
	start()

func _on_Hit_pressed():
	if game_started == true:
		draw_card(true)


func _on_Stand_pressed():
	pass # Replace with function body.
