extends KinematicBody2D

export var speed := Vector2(300.0, 300.0)
export var gravity := 700.0
export var slipperiness := 6

var up := Vector2.UP
var canDoubleJump := true
var velocity := Vector2.ZERO
var slippery := false

func set_slippery(value: bool):
	slippery = value

func _ready() -> void:
	$AnimatedSprite.play("idle")

func _physics_process(delta: float) -> void:
	var attempting_jump :=  velocity.y >= 0.0 and Input.is_action_just_pressed("ui_accept")
	var floored := is_on_floor()
	
	if floored || attempting_jump:
		if attempting_jump && (floored || canDoubleJump):
			$AnimatedSprite.play("jump")
			$Particles2D.emitting = true
			$Particles2D2.emitting = true
			velocity.y = -speed.y
		else:
			$AnimatedSprite.play("idle")
		canDoubleJump = floored

	var x_strength = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"))
	
	if(slippery):
		velocity.x += speed.x * x_strength / slipperiness
		if velocity.x > speed.x:
			velocity.x = speed.x
		if velocity.x < -speed.x:
			velocity.x = -speed.x
	else :
		velocity.x = speed.x * x_strength
	
	velocity.y += gravity * delta
	
	
	velocity = move_and_slide(velocity, up)
