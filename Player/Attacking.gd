extends Node

@onready var SM = get_parent()
@onready var player = get_node("../..")
var is_attacking = false

func _ready():
	await player.ready

func start():
	if !is_attacking:
		is_attacking = true
		player.set_animation("Attack1",Vector2(5,7))
		$Timer.start()

func end():
	player.get_node("AnimatedSprite2D").offset.y = 0

func physics_process(_delta):
	pass



func _on_timer_timeout():
	if SM.state_name == "Attacking":
		player.attack()
		is_attacking = false
		
