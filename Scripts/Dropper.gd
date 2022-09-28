extends Node2D

onready var player = get_node("/root/Player") 
onready var stick = preload("res://Game Scenes/Dropper/Dropper Sticks/stick.tscn")
onready var ball = preload("res://Game Scenes/Dropper/Dropper Ball/Ball.tscn")

var corner = Vector2(40,70)
var dist_between_sticks = 70
var dist_between_columns = 50
var sticks_per_row = 14
var columns = 6

var dropped = false

func new_stick(pos):
	var new_stick = stick.instance()
	add_child(new_stick)
	new_stick.position = pos

func load_sticks():
	var stagger = 0
	for i in range(columns):
		if i % 2 != 0:
			stagger = 40
		else:
			stagger = 0
		for j in range(sticks_per_row):
			var stick_pos = Vector2((corner.x + j * dist_between_sticks) + stagger, corner.y + i * dist_between_columns)
			new_stick(stick_pos)

func reset_ball():
	get_node("Ball").queue_free()
	dropped = false

func drop_ball():
	var new_ball = ball.instance()
	add_child(new_ball)
	new_ball.position = $Overlay.position

func _process(delta):
	if dropped == false:
		$Overlay.position.x = get_viewport().get_mouse_position().x
		if Input.is_action_just_pressed("click"):
			dropped = true
			drop_ball()
	$Control/Money.text = "Money:" + str(Player.money)

func _ready():
	load_sticks()

func _on_Go_Back_pressed():
		get_tree().change_scene("res://Main.tscn")
