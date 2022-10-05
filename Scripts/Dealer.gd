extends Node

onready var card = preload("res://Game Scenes/Blackjack/Card.tscn")
onready var parent = get_parent()
onready var dealer_hand = get_node("../Control/VBoxContainer/HBoxContainer/VBoxContainer2/HBoxContainer")
onready var hand_label = get_node("../Control/VBoxContainer/HBoxContainer/VBoxContainer2/Label")

var hand = []

func update_hand_val(val):
	hand_label.text = "Dealer Hand Value:" + str(val)

func reveal_hand():
	if !hand.empty():
		for i in range(hand.size()):
			dealer_hand.get_child(i).texture = load("res://Assets/Cards/" + str(parent.translate_num_to_card(hand[i])) + ".png")
		update_hand_val(get_hand_val())

func load_image(path):
	var new_card = card.instance()
	new_card.texture = load(path)
	dealer_hand.add_child(new_card)

func update_hand_img(card_num):
	load_image("res://Assets/Cards/back.png")

func check_hand_for_21():
	var hand_val = get_hand_val()
	if hand_val == 21:
		parent.lose()
	elif hand_val > 21:
		parent.win()
func card_drawn(card_num):
	hand.append(card_num)
	update_hand_img(card_num)
	check_hand_for_21()

func get_hand_val():
	var total = 0
	for i in range(hand.size()):
		total += hand[i]
	return total

func update_ai():
	if get_hand_val() < 17:
		parent.draw_card(false)

func _ready():
	pass # Replace with function body.
