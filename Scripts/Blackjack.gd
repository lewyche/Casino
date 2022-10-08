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

var standing = false

var hand = []

func _ready():
	randomize()


func game_end():
	game_ended = true
	dealer.reveal_hand()
	#set start button to restart to encourage player to click
	start.text = "Restart"

func win():
	#prevent from winning when game has ended
	if !game_ended:

		var winnings = int(bet_input.text) * 1.5
		#tell the player that they have won
		win_text.text += " " + str(winnings)
		win_text.text = "Won!"
		
		player.money += winnings

		game_end()
		
func lose():
	#prevent from losing when the game has ended
	if !game_ended:
		#tell player they have lost
		win_text.text = "Lost!"
		game_end()

func get_rand_card():
	return randi() % 13 + 1

func load_card_img(path):
	#create a textureRect of the card
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

#add the image of the card to your hand
func get_card_img(card_num):
	var img_name = translate_num_to_card(card_num)
	load_card_img("res://Assets/Cards/" + img_name + ".png")
	
#add all cards in hand to get total hand value
func get_hand_val():
	var total = 0
	for i in hand:
		total += i
	return total
	
func update_hand_val():
	var total = get_hand_val()
	hand_label.text = "Hand value: " + str(total)

#check hand immediate win or lose conditions
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
		
		#update the dealer on what you did
		dealer.update_ai()
		
		check_hand_for_21()
	else:
		#handle card drawing operations on dealers side
		var rand_card = get_rand_card()
		dealer.card_drawn(rand_card)

func start():
	if game_started == false:
		#everyone starts with one card
		draw_card(true)
		game_started = true

#check if the bet is vaild input
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
	#delete the textureRects from both hands
	for i in range(player_hand.get_children().size()):
		player_hand.get_child(i).queue_free()
	for i in range(dealer.dealer_hand.get_children().size()):
		dealer.dealer_hand.get_child(i).queue_free()

func reset():
	#clear hand arrays
	hand.clear()
	dealer.hand.clear()
	#delete images of cards
	delete_hands()
	#reset hand values
	update_hand_val()
	dealer.update_hand_val("???")
	
	game_ended = false
	#reset text
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
		if check_hand_for_21() == false:
			draw_card(true)

func check_hand():
	#checking hand once standing
	if !game_ended:
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
	standing = true
	dealer.update_ai()
	check_hand()
	dealer.reveal_hand()
