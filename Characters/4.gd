extends KinematicBody2D

export var speed := Vector2(600.0, 600.0)
export var gravity := 700.0
export var slipperiness := 12

var up := Vector2.UP
var canDoubleJump := true
var velocity := Vector2.ZERO
var slippery := false
var gooooood := false

func die():
	get_tree().change_scene_to(load("res://Scenes/Death.tscn"))

func entered_goo():
	gooooood = true

func exited_goo():
	gooooood = false

func set_slippery(value: bool):
	slippery = value

func _ready() -> void:
	$AnimatedSprite.play("idle")

func timer_start() -> void:
	$Timer.start()

func bounce() -> void:
	velocity.y = -900
	canDoubleJump = true

func _physics_process(delta: float) -> void:
	var attempting_jump :=  velocity.y >= 0.0 and Input.is_action_just_pressed("ui_accept")
	var floored := is_on_floor()
	
	if floored || attempting_jump:
		if attempting_jump && (floored || canDoubleJump):
			$AnimatedSprite.play("jump")
			$Particles2D.emitting = true
			$Particles2D2.emitting = true
			if not Settings.muted:
				$Jets.play()
			velocity.y = -speed.y if not gooooood else -speed.y / 2.0
		else:
			$AnimatedSprite.play("idle")
		canDoubleJump = floored

	var x_strength = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if gooooood:
		x_strength = x_strength / 2.0
	
	if slippery:
		velocity.x += speed.x * x_strength / slipperiness
		if velocity.x > speed.x:
			velocity.x = speed.x
		if velocity.x < -speed.x:
			velocity.x = -speed.x
	else :
		velocity.x = speed.x * x_strength
	
	velocity.y += gravity * delta
	
	
	velocity = move_and_slide(velocity, up)


func _on_Timer_timeout() -> void:
	if(!gooooood):
		Settings.score += rand_range(0, 20) + 1
	else:
		Settings.score += 1
