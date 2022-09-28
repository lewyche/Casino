extends Area2D

onready var scene = get_parent()
onready var player = get_node("/root/Player")

export var spin_speed = 17
var spin_velocity = 0

var spinning = false

#is pointer on area
var areas = [false,false,false,false,false,false,false,false]
var multiplers = [0.02, 0.05, -0.15, 0.1, -0.5, 2, -0.2, 0.05]

func _ready():
	randomize()


func spin():
	#set rotation of wheel to random degree before spinning
	rotation_degrees = rand_range(0, 360)
	spin_velocity = 1
	spinning = true

func _physics_process(delta):
	#slowing down of wheel
	spin_velocity = lerp(spin_velocity, 0, 0.02)
	#spinning
	rotation_degrees += spin_velocity * spin_speed
	

	#once velocity gets below certain threshold, stop
	var spin_threshold = 0.01
	if spin_velocity <= spin_threshold:
		spin_velocity = 0
	if spin_velocity == 0:
		if spinning != false:
			for i in range(areas.size()):
				if areas[i] == true:
					#get winner and display on screen
					scene.winner(get_node("Node/Area2D" + str(i + 1)))
					
					
					if multiplers[i] < 0:
						#take away player money
						player.money -= (multiplers[i] * -1) * player.money
					else:
						#give player money
						player.money += multiplers[i] * player.money
					spinning = false

func _on_Area2D_body_entered(body):
	areas[0] = true

func _on_Area2D_body_exited(body):
	areas[0] = false

func _on_Area2D2_body_entered(body):
	areas[1] = true

func _on_Area2D2_body_exited(body):
	areas[1] = false

func _on_Area2D3_body_entered(body):
	areas[2] = true
	
func _on_Area2D3_body_exited(body):
	areas[2] = false
	
func _on_Area2D4_body_entered(body):
	areas[3] = true

func _on_Area2D4_body_exited(body):
	areas[3] = false

func _on_Area2D5_body_entered(body):
	areas[4] = true

func _on_Area2D5_body_exited(body):
	areas[4] = false

func _on_Area2D6_body_entered(body):
	areas[5] = true

func _on_Area2D6_body_exited(body):
	areas[5] = false

func _on_Area2D7_body_entered(body):
	areas[6] = true
	
func _on_Area2D7_body_exited(body):
	areas[6] = false

func _on_Area2D8_body_entered(body):
	areas[7] = true

func _on_Area2D8_body_exited(body):
	areas[7] = false

