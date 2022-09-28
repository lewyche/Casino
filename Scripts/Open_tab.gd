extends VBoxContainer

onready var player = get_node("/root/Player")
onready var lottery = get_node("../../../../")
onready var selected_pack = get_node("HBoxContainer/TextureRect")
onready var description = get_node("HBoxContainer/Label")

#possible lottery results
var common = [75, 50, 60, 55, 200, 120, 100, 99, 25]
var rare = [500, 750, 800, 1200, 2500, 599, 990, 1000]
var super = [500000, 102, 8000, 12000,  7000, 5000, 6700, 10000]

var pack_selected = -1

var img_src = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

func update_description():
	description.text = "Owned: " + str(lottery.pack_numbers[pack_selected])

func add_payout(payout):
	description.text = "Owned: " + str(lottery.pack_numbers[pack_selected]) + "\n Payout: " + str(payout)

func load_selected_pack():
	if img_src != "" or pack_selected == -1:
		selected_pack.texture = load(img_src)
		update_description()

func open_pack():
	var result = 0
	if pack_selected == 0:
		result = common[randi() % common.size()]
	elif pack_selected == 1:
		result = rare[randi() % rare.size()]
	elif pack_selected == 2:
		result = super[randi() % super.size()]
	player.money += result
	return result
	
func open_all_packs():
	var total = 0
	for i in range(lottery.pack_numbers[pack_selected]):
		total += open_pack()
	return total

func _on_Open_pressed():
	if pack_selected != -1 and lottery.pack_numbers[pack_selected] > 0:
		var payout = open_pack()
		lottery.pack_numbers[pack_selected] -= 1
		add_payout(payout)
		
func _on_Open_all_pressed():
	if pack_selected != -1 and lottery.pack_numbers[pack_selected] > 0:
		var payout = open_all_packs()
		lottery.pack_numbers[pack_selected] = 0
		add_payout(payout)
		


func _on_common_pack_pressed():
	pack_selected = 0
	img_src = "res://Assets/common.png"
	load_selected_pack()

func _on_rare_pack_pressed():
	pack_selected = 1
	img_src = "res://Assets/rare.png"
	load_selected_pack()

func _on_super_pack_pressed():
	pack_selected = 2
	img_src = "res://Assets/super.png"
	load_selected_pack()

