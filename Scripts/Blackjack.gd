extends Node2D

onready var card = preload("res://Game Scenes/Blackjack/Card.tscn")
onready var player_hand = get_node("Control/VBoxContainer/HBoxContainer/VBoxContainer/player_hand")
onready var hand_label = get_node("Control/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/Label")
onready var bet_input = get_node("Control/VBoxContainer/HBoxContainer2/VBoxContainer2/TextEdit")
onready var start = get_node("Control/VBoxContainer/HBoxContainer2/VBoxContainer2/Start")
onready var win_text = get_node("Control/Win_txt")
onready var dealer = get_node("Dealer")
onready var player = get_node("/root/Player")

var game_started = false
var game_ended = false

var hand = []

func _ready():
	randomize()

func game_end():
	game_ended = true
	dealer.reveal_hand()
	start.text = "Restart"

func win():
	if !game_ended:

		var winnings = int(bet_input.text) * 1.5
		win_text.text += " " + str(winnings)
		win_text.text = "Won!"
		
		player.money += winnings

		game_end()
func lose():
	if !game_ended:
		win_text.text = "Lost!"
		game_end()

func get_rand_card():
	return randi() % 13 + 1

func load_card_img(path):
	var new_card = card.instance()
	new_card.texture = load(path)
	player_hand.add_child(new_card)

func translate_num_to_card(card_num):
	var img_name = ""
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
	return img_name

func get_card_img(card_num):
	var img_name = translate_num_to_card(card_num)
	load_card_img("res://Assets/Cards/" + img_name + ".png")
	
func get_hand_val():
	var total = 0
	for i in hand:
		total += i
	return total
	
func update_hand_val():
	var total = get_hand_val()
	hand_label.text = "Hand value: " + str(total)

func check_hand_for_21():
	if get_hand_val() == 21:
		win()
		return true
	elif get_hand_val() > 21:
		lose()
		return true
	return false
	
func draw_card(is_player):
	if is_player == true:
		var rand_card = get_rand_card()
		hand.append(rand_card)
		get_card_img(rand_card)
		update_hand_val()
		
		dealer.update_ai()
		
		check_hand_for_21()
	else:
		var rand_card = get_rand_card()
		dealer.card_drawn(rand_card)

func start():
	if game_started == false:
		draw_card(true)
		game_started = true

func check_bet():
	if bet_input.text != "":
		if int(bet_input.text) > 0:
			if int(bet_input.text) <= player.money:
				return true
			else:
				return false
		else:
			return false
	else:
		return false

func delete_hands():
	for i in range(player_hand.get_children().size()):
		player_hand.get_child(i).queue_free()
	for i in range(dealer.dealer_hand.get_children().size()):
		dealer.dealer_hand.get_child(i).queue_free()

func reset():
	hand.clear()
	dealer.hand.clear()
	delete_hands()
	update_hand_val()
	dealer.update_hand_val("???")
	game_ended = false
	start.text = "start"
	win_text.text = ""

func _on_Start_pressed():
	if check_bet() == true:
		start()
		player.money -= int(bet_input.text)
		reset()


func _on_Hit_pressed():
	if game_started == true && game_ended == false:
		var hand_val = get_hand_val()
		if hand_val < 21:
			draw_card(true)
		elif hand_val == 21:
			win()
		elif hand_val > 21:
			lose()

func check_hand():
	if check_hand_for_21() == false:
		var player_hand_val = get_hand_val()
		var dealer_hand_val = dealer.get_hand_val()
		if player_hand_val > dealer_hand_val:
			win()
		elif player_hand_val < dealer_hand_val:
			lose()
		elif player_hand_val == dealer_hand_val:
			win()
		

func _on_Stand_pressed():
	dealer.update_ai()
	check_hand()
	dealer.reveal_hand()
