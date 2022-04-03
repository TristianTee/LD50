extends KinematicBody2D

export var size := 56

func _on_Area2D_body_entered(body: Node) -> void:
	if not Settings.muted:
		$AudioStreamPlayer2D.play()
	body.call('bounce')

func die() -> void:
	self.queue_free()
