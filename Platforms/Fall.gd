extends KinematicBody2D

export var time = 0.5
export var gravity = 700.0
export var speed = Vector2(0.0,0.0)
export var size := 120

var falling := false
var velocity = Vector2.ZERO

func _ready() -> void:
	$Timer.wait_time = time

func _physics_process(delta: float) -> void:
	if falling :
		velocity.y += gravity * delta
	velocity = move_and_slide(velocity)

func _on_Area2D_body_entered(body: Node) -> void:
	if not falling:
		$Timer.start()
		$Area2D.monitoring = false

func _on_Timer_timeout() -> void:
	$AudioStreamPlayer2D.play()
	falling = true

func die() -> void:
	self.queue_free()

