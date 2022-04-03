extends Area2D

var speed := 0

func _physics_process(delta: float) -> void:
	position.y = position.y + (speed * delta)

func start() -> void: 
	speed = -10
	$Timer.start()

func _on_Timer_timeout() -> void:
	speed -= 10

func _on_GOO_body_entered(body: Node) -> void:
	body.call('entered_goo')

func _on_GOO_body_exited(body: Node) -> void:
	body.call('exited_goo')

func _on_Area2D_body_entered(body: Node) -> void:
	body.call('die')
