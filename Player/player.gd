extends CharacterBody2D

@onready var SM = $StateMachine

var jump_power = Vector2.ZERO
var direction = 1

@export var gravity = Vector2(0,30)

@export var move_speed = 100
@export var max_move = 500

@export var jump_speed = 200
@export var max_jump = 1500

@export var leap_speed = 200
@export var max_leap = 1500



var moving = false
var is_jumping = false
var double_jumped = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite
var health : int = 100 
var dying = false

func _physics_process(_delta):
	if !dying:
		velocity.x = clamp(velocity.x,-max_move,max_move)
			
		if should_direction_flip:
			if direction < 0 and not $AnimatedSprite2D.flip_h: 
				$AnimatedSprite2D.flip_h = true
				$Attack1.target_position.x = -1*abs($Attack1.target_position.x)
			if direction > 0 and $AnimatedSprite2D.flip_h: 
				$AnimatedSprite2D.flip_h = false
				$Attack1.target_position.x = abs($Attack1.target_position.x)
		
		if is_on_floor():
			double_jumped = false
			if Input.is_action_just_pressed("Attack1"):
				SM.set_state("Attacking")
	else:
		set_animation("Died")

func is_moving():
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("Right") - Input.get_action_strength("Left"),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("Left"):
		direction = -1
	if event.is_action_pressed("Right"):
		direction = 1

func set_animation(anim, off=Vector2.ZERO):
	if $AnimatedSprite2D.is_playing() and anim != "Died":
		if $AnimatedSprite2D.animation == anim: return
		if !$AnimatedSprite2D.sprite_frames.get_animation_loop($AnimatedSprite2D.animation): return
	if $AnimatedSprite2D.sprite_frames.has_animation(anim): 
		$AnimatedSprite2D.play(anim)
	else: $AnimatedSprite2D.play()
	$AnimatedSprite2D.offset = off

func attack():
	if $Attack1.is_colliding():
		$Hit_Sound.play()
		var target = $Attack1.get_collider()
		if target.has_method("damage"):
			target.damage()
	if $Attack2.is_colliding():
		var target = $Attack2.get_collider()
		if target.has_method("damage"):
			target.damage()

func die():
	if !dying:
		Global.player_health -= 10
		set_animation("Hit")
		$PlayerHit.play()
		if Global.player_health <= 0:
			dying = true #find way to set dying boolean back to false after player dies.
			set_animation("Died")
			$Lose.play()
		
		
		


func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "Died":
		get_tree().change_scene_to_file("res://Scenes/Levels/Dungeon_1.tscn")
	elif !dying:
		SM.set_state("Idle")


#func _on_body_entered(body):
#var current_level = get_tree().current_scene.scene_file_path
#if body.name == "Player":
#if current_level == "res://Scenes/Dungeon1.tscn":
#get_tree().change_scene_to_file("res://Scenes/Dungeon2.tscn")
#elif current_level == "res://Scenes/Dungeon2.tscn":
#get_tree().change_scene_to_file("res://Scenes/Dungeon3.tscn")
#elif current_level == "res://Scenes/Dungeon3.tscn":
#get_tree().change_scene_to_file("res://Scenes/End_Game.tscn")
