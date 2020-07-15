extends Node2D

var current_dialog
var current_line
var dialogs = {}
var answ = -1

func load_file(filename):
	var result = ""
	var f = File.new()
	if f.file_exists(filename):
		f.open(filename, File.READ)
		while not f.eof_reached():
			result = result + f.get_line() + "\n"
		f.close()
		return result
	else:
		return "i bugged out :/"

func load_json_file(data): 
	dialogs = JSON.parse(load_file(data)).result

func talk(id_dialog):
	current_dialog = dialogs[id_dialog]
	current_line = 0
	next_line()
	var lastdialog = id_dialog

func ask(questions):
	$questionbox.ask(questions)

func next_line():
	if current_dialog:
		if current_dialog.size() > current_line:
			get_parent().expression_callback(
				current_dialog[current_line][1], 
				current_dialog[current_line][2], 
				not (current_dialog[current_line][1]=="pants" or current_dialog[current_line][1]=="money"),
				current_dialog[current_line].size()>3
			)
			
			var _ques = Array()
			$dialogbox.say(current_dialog[current_line][0])
			if current_dialog[current_line].size()>4:
				for x in current_dialog[current_line][4]:
					_ques.append(x[0])
				$questionbox.ask(_ques)
			
			current_line += 1
		else: get_parent().default_expression()

func _process(delta): 
	if answ >= 0:
		talk(current_dialog[current_line-1][4][answ][1])
		answ = -1
