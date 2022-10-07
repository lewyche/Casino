extends Node2D

var symbols = ['¥','®', '$❤', '¶', '§', '«']
onready var slot1 = get_node("Control/Slot1")
onready var slot2 = get_node("Control/Slot2")
onready var slot3 = get_node("Control/Slot3")

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

func calculate_winnings():
	pass

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
	if !spinning:
		play()
