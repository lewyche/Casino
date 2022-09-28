extends StaticBody2D

onready var player = get_node("/root/Player") 
onready var percent = get_node("../Control/Percent")
var holes = [false, false, false, false, false]
var values = [0.75,2,0.5,1,1.2]

func _ready():
	$Area2D/Label.text = str(values[0])
	$Area2D2/Label.text = str(values[1])
	$Area2D3/Label.text = str(values[2])
	$Area2D4/Label.text = str(values[3])
	$Area2D5/Label.text = str(values[4])

func set_percent_label(num):
	percent.text = str(values[num] * 100 - 100) + "%"

func dropped(num):
	if get_parent().dropped == true:
		holes[num] = true
		player.money = player.money * values[num]
		set_percent_label(num)
		get_parent().reset_ball()
	
func _on_Area2D_body_entered(body):
	var num = 0
	dropped(num)

func _on_Area2D2_body_entered(body):
	var num = 1
	dropped(num)
	
func _on_Area2D3_body_entered(body):
	var num = 2
	dropped(num)

func _on_Area2D4_body_entered(body):
	var num = 3
	dropped(num)
func _on_Area2D5_body_entered(body):
	var num = 4
	dropped(num)
