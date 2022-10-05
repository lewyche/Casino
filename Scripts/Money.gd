extends Label

onready var player = get_node("/root/Player")

func _ready():
	pass # Replace with function body.

func _process(_delta):
	text = "Money: " + str(player.money)
