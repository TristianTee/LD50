extends Node2D

func _on_Button_pressed() -> void:
	get_tree().change_scene_to(load("res://Scenes/Main.tscn"))
