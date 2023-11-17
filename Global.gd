extends Node

var player_health : int = 100

var levels = ["Dungeon1", "plains_2", "Dungeon3"]

# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var current_level = get_tree().current_scene.scene_file_path
		if current_level == "res://Scenes/Levels/Dungeon_1.tscn": 
			var p = get_node_or_null("/root/Dungeon1/Pause_Menu")
			
			if p != null:
				if p.visible:
					get_tree().paused = false
					p.hide()
				else:
					get_tree().paused = true
					p.show()
		elif current_level == "res://Scenes/Levels/plains_2.tscn":
			var p = get_node_or_null("/root/Plains2/Pause_Menu")
			
			if p != null:
				if p.visible:
					get_tree().paused = false
					p.hide()
				else:
					get_tree().paused = true
					p.show()
		elif current_level == "res://Scenes/Levels/Dungeon_3.tscn":
			var p = get_node_or_null("/root/Dungeon_3/Pause_Menu")
			
			if p != null:
				if p.visible:
					get_tree().paused = false
					p.hide()
				else:
					get_tree().paused = true
					p.show()

