extends VBoxContainer

onready var player = get_node("/root/Player")
onready var lottery = get_node("../../../../")
onready var buy_menu = get_node("VBoxContainer/HBoxContainer2/Label")

var pack_selected = -1

func _ready():
	pass # Replace with function body.

func update_pack_description():
	if pack_selected != -1:
		buy_menu.text = "Selected: " + lottery.packs[pack_selected] 
		buy_menu.text += "\n Owned: " + str(lottery.pack_numbers[pack_selected])
		buy_menu.text += "\n Cost: " + lottery.cost[pack_selected]

func buy():
	if pack_selected != -1 and player.money >= int(lottery.cost[pack_selected]):
		lottery.pack_numbers[pack_selected] += 1
		player.money -= int(lottery.cost[pack_selected])

		
#Buy button
func _on_Button_pressed():
	buy()
	update_pack_description()

func _on_Buy_max_pressed():
	while player.money >= int(lottery.cost[pack_selected]):
		buy()
	update_pack_description()

func _on_common_pack_pressed():
	pack_selected = 0
	update_pack_description()

func _on_rare_pack_pressed():
	pack_selected = 1
	update_pack_description()

func _on_super_pack_pressed():
	pack_selected = 2
	update_pack_description()


