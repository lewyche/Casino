extends Node

export var money = 500
var original_val = money

func _ready():
	load_file()
	original_val = money

func load_file():
	var read_file = File.new()
	read_file.open("res://Save_files/save.txt", File.READ)
	var line = read_file.get_line()
	if line != "":
		money = int(line)
	read_file.close()

func save_file():
	var save_file = File.new()
	save_file.open("res://Save_files/save.txt", File.WRITE)
	var save_dict = {
		"money" : money
	}
	save_file.store_line(to_json(save_dict))
	save_file.close()
	

func _process(delta):
	#detect when money is changed
	if original_val != money:
		original_val = money
		save_file()
