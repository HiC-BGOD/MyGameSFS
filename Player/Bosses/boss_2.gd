extends CharacterBody2D

@onready var SM = $StateMachine

@export var walking = 300
@export var running = 700

@export var path = [Vector2(1950,570), Vector2(2210,570)]

var direction = 1
var health : int = 100

func _ready():
	position = path[0]
	velocity.x = walking
	SM.set_state("Move")

func _physics_process(_delta):
	move_and_slide()
	
	if velocity.x < 0 and not $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = true
		direction = -1
		$Attack1.target_position.x = -1*abs($Attack1.target_position.x)
	if velocity.x > 0 and $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = false
		direction = 1
		$Attack1.target_position.x = abs($Attack1.target_position.x)
	if $AnimatedSprite2D.animation == "Attack2": 
		$AnimatedSprite2D.offset.x = 7*direction
		$Attack.target_position.x = -1*abs($Attack.target_position.x)
	if velocity.x > 0 and $AnimatedSprite2D.flip_h: 
		$AnimatedSprite2D.flip_h = false
		direction = 1
		$Attack.target_position.x = abs($Attack.target_position.x)
	if $AnimatedSprite2D.animation == "Attack": 
		$AnimatedSprite2D.offset.x = 7*direction
	else: $AnimatedSprite2D.offset.x = 0

func set_animation(anim):
	if $AnimatedSprite2D.animation == anim and $AnimatedSprite2D.is_playing(): return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): $AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()

func damage():
	if SM.state_name != "Die":
		SM.set_state("Die")


func should_attack():
	if $Attack1.is_colliding() and $Attack1.get_collider().name == "Player":
		print($Attack1.get_collider())
	if $Attack1.is_colliding() and $Attack1.get_collider().name == "Player":
		return true
	return false

func attack_target():
	if $Attack1.is_colliding():
		return $Attack1.get_collider()
	if $Attack1.is_colliding():
		return $Attack1.get_collider()
	return null

func _on_AnimatedSprite_animation_finished():
	if SM.state_name == "Attack":
		SM.set_state("Move")
	if SM.state_name == "Die":
		queue_free()


func _on_Above_and_Below_body_entered(body):
	if body.name == "Player" and SM.state_name != "Die":
		body.die()
