extends TileMap

var speed := 0

func _physics_process(delta: float) -> void:
	position.y = position.y + (speed * delta)

func start() -> void: 
	speed = -20
	$Timer.start()

func _on_Timer_timeout() -> void:
	speed -= 20
