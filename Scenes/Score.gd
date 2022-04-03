extends Control

func _process(delta: float) -> void:
	$Panel/Score.text = String(Settings.score)
