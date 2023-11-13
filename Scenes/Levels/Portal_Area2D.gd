extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	var current_level = get_tree().current_scene.scene_file_path
	if body.name == "Player":
		if current_level == "res://Scenes/Levels/Dungeon_1.tscn":
			get_tree().change_scene_to_file("res://Scenes/Levels/plains_2.tscn")
		elif current_level == "res://Scenes/Levels/plains_2.tscn":
			get_tree().change_scene_to_file("res://Scenes/Levels/Dungeon_3.tscn")
		elif current_level == "res://Scenes/Dungeon_3.tscn":
			get_tree().change_scene_to_file("res://Scenes/End_Game.tscn")
