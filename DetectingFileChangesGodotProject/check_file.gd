extends Node

## YOU CAN PRESS ESQ TO QUIT

var debug_build : bool = false

var file_exists_in_dir : bool = false

var absolute_debug_path : String = "res://"

@export var file_path_to_search : String = "Icon/icon.svg"

@onready var debug_label: Label = $DebugLabel

func _ready() -> void:
	
	var dir_path : String
	
	var dir : DirAccess
	
	debug_build = OS.is_debug_build()
	
	if not debug_build:
		
		# Get the path to the executable
		var exe_path = OS.get_executable_path()
		var base_dir = exe_path.get_base_dir()  # This gives the directory of the executable 
		
		dir_path = base_dir
		
		dir_path = dir_path.substr(0, get_last_occurence_num(dir_path, '/', 3))
		
	else:
		dir_path = absolute_debug_path
	
	dir = DirAccess.open(dir_path)
	
	file_exists_in_dir = dir.file_exists(file_path_to_search) # or dir.file_exists("Icon/icon.svg")
	
	debug_label.text = "Debug Mode: " + str(debug_build) + ", " + file_path_to_search \
	 + " exists: " + str(file_exists_in_dir) # + '\n' + "dir_path: "  + dir_path

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("quit"):
		
		get_tree().quit()
	

func get_last_occurence_num(s : String, char : String, n : int = 1) -> int:
	
	## we are assuming n > 0
	
	var i : int = s.length() - 1
	
	while i >= 0 && n > 0:
		
		n -= int(s[i] == char)
		
		i -= 1
	
	return i + 1
