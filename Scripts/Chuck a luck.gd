extends Node2D

onready var dice1 = get_node("Control/VBoxContainer/Dice/Dice1")
onready var dice2 = get_node("Control/VBoxContainer/Dice/Dice2")
onready var dice3 = get_node("Control/VBoxContainer/Dice/Dice3")

onready var prediction_label = get_node("Control/VBoxContainer/Bets/text/dice_roll_pred")
onready var payout = get_node("Control/VBoxContainer/Bets/HBoxContainer2/VBoxContainer/payout")

onready var text_edit = get_node("Control/VBoxContainer/Bets/HBoxContainer2/VBoxContainer/TextEdit")

onready var player = get_node("/root/Player")

var dice_roll_prediction = 0

var bet = 0

func _ready():
	randomize()

func input_error():
	pass
	
func display_dice(val, node):
	if val == 1:
		node.texture = load("res://Assets/one.png")
	elif val == 2:
		node.texture = load("res://Assets/two.png")
	elif val == 3:
		node.texture = load("res://Assets/three.png")	
	elif val == 4:
		node.texture = load("res://Assets/four.png")
	elif val == 5:
		node.texture = load("res://Assets/five.png")
	elif val == 6:
		node.texture = load("res://Assets/six.png")
	else:
		print(val)
		return
		
func error(err_msg):
	payout.text = "Payout: " + err_msg 

func calculate_payout(one, two, three):
	var correct_guesses = 0
	if one == dice_roll_prediction:
		correct_guesses += 1
	if two == dice_roll_prediction:
		correct_guesses += 1
	if three == dice_roll_prediction:
		correct_guesses += 1
	
	var payout = bet * correct_guesses
	player.money += payout
	set_payout(payout)
	
func roll():

	if dice_roll_prediction == 0:
		error("Error!! no dice roll prediction provided")
		return
	bet = int(text_edit.text)
	if bet == 0 :
		error("Error!! not bet entered")
		return

	if Player.money < bet || bet <= 0:
		error("Error!! bet problem")
		return
	
	player.money -= bet

	var one = randi() % 6 + 1
	var two = randi() % 6 + 1
	var three = randi() % 6 + 1
	
	display_dice(one, dice1)
	display_dice(two, dice2)
	display_dice(three, dice3)
	
	calculate_payout(one, two, three)

func change_prediction():
	prediction_label.text = "Dice roll prediction:" + str(dice_roll_prediction)

func set_payout(pay):
	payout.text = "Payout: " + str(pay)

func _process(delta):
	$Control/Money.text = "Money: " + str(player.money)

func _on_Button_pressed():
	roll()

func _on_one_pred_pressed():
	dice_roll_prediction = 1
	change_prediction()


func _on_two_pred_pressed():
	dice_roll_prediction = 2
	change_prediction()


func _on_three_pred_pressed():
	dice_roll_prediction = 3
	change_prediction()


func _on_four_pred_pressed():
	dice_roll_prediction = 4
	change_prediction()


func _on_five_pred_pressed():
	dice_roll_prediction = 5
	change_prediction()


func _on_six_pred_pressed():
	dice_roll_prediction = 6
	change_prediction()

func _on_Go_Back_pressed():
	get_tree().change_scene("res://Main.tscn")
