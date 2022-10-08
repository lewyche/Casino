extends Node2D

var symbols = ['¥','®', '$❤', '¶', '§', '«']
onready var slot1 = get_node("Control/Slot1")
onready var slot2 = get_node("Control/Slot2")
onready var slot3 = get_node("Control/Slot3")

onready var win_label = get_node("Control/Label")

onready var player = get_node("/root/Player")

var spinning = false
var i = 0
var j = 0

var time_between_switch_sym = 0.1

func _ready():
	randomize()

func get_rand_symbol():
	return symbols[randi() % symbols.size()]

func play():
	spinning = true

func set_win_label(message):
	win_label.text = message

func check_symbols(same_symbols):
	if same_symbols == 2:
		return 500 * 1.5

	elif same_symbols == 3:
		return 500 * 3
	else:
		return 0

func calculate_winnings():
	var winnings = 0
	
	var slots = [slot1.text, slot2.text, slot3.text]
	#iterate through all the symbols to find number of matching ones
	for i in symbols:
		var same_symbols = 0
		for j in slots:
			if i == j:
				same_symbols += 1
		winnings = check_symbols(same_symbols)
		if winnings != 0:
			set_win_label("You Won: " + str(winnings))
			return
			
	player.money += winnings

func _process(delta):
	if spinning:
		if i == 10:
			slot1.text = get_rand_symbol()
			slot2.text = get_rand_symbol()
			slot3.text = get_rand_symbol()
			i = 0
			j += 1
		i += 1
		if j == 10:
			spinning = false
			calculate_winnings()
			i = 0
			j = 0
		

func _on_Play_pressed():
	player.money -= 500
	set_win_label("Only 500 dollars!!!!")
	if !spinning:
		play()
