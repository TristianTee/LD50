extends KinematicBody2D

export var size := 192

func _on_Area2D_body_entered(body: Node) -> void:
	body.call('set_slippery', true)

func _on_Area2D_body_exited(body: Node) -> void:
	body.call('set_slippery', false)

func die() -> void:
	self.queue_free()

