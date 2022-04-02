extends Control

func _on_ready():
	$Toggle.pressed = Settings.muted

func _on_Toggle_pressed() -> void:
	$Toggle.pressed = not Settings.muted
	Settings.muted = not Settings.muted
