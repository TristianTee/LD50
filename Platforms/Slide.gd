extends KinematicBody2D


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	pass


func _on_Area2D_body_entered(body: Node) -> void:
	body.call('set_slippery', true)


func _on_Area2D_body_exited(body: Node) -> void:
	body.call('set_slippery', false)
