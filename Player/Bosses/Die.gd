extends Node

@onready var SM = get_parent()
@onready var enemy = get_node("../..")

func _ready():
	await enemy.ready

func start():
	enemy.set_animation("Death")
	enemy.velocity = Vector2.ZERO
	enemy.collision_layer = 0
	enemy.collision_mask = 0
	enemy.set_animation("Die")
	enemy.velocity = Vector2.ZERO
	enemy.collision_layer = 0
	enemy.collision_mask = 0


