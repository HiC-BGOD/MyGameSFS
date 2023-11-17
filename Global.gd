extends Node

var player_health : int = 100
# Called when the node enters the scene tree for the first time.
func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		var p = get_node_or_null("/root/Dungeon1/Pause_Menu")
		
		if p != null:
			if p.visible:
				get_tree().paused = false
				p.hide()
			else:
				get_tree().paused = true
				p.show()

