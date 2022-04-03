extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if not Settings.muted:
		$AudioStreamPlayer.play()

func _process(delta: float) -> void:
	if Settings.muted && $AudioStreamPlayer.playing:
		$AudioStreamPlayer.stop()
	if not Settings.muted && not $AudioStreamPlayer.playing:
		$AudioStreamPlayer.play()

func _on_Begin_pressed() -> void:
		get_tree().change_scene_to(load("res://Scenes/InfiniteLevel.tscn"))
