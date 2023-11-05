extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child_count() == 1:
		var player = load("res://Player/player.tscn")
		var p = player.instantiate()
		p.position = $Marker2D.position
		add_child(p)

