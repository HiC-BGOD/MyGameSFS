extends Node

var player_health : int = 100

var levels = ["Dungeon1", "plains_2", "Dungeon3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var check_menu = [
			"/root/Dungeon1/Pause_Menu"
			,"/root/Plains2/Pause_Menu"
			,"/root/Dungeon_3/Pause_Menu"
		]
		var found_c = false
		for c in check_menu:
			var p = get_node_or_null(c)
			if p != null:
				found_c = true
				if p.visible:
					get_tree().paused = false
					p.hide()
				else:
					get_tree().paused = true
					p.show()
		if not found_c:
			get_tree().quit()
