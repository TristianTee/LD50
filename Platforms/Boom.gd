extends KinematicBody2D

export var size := 40

func die() -> void:
	self.queue_free()
