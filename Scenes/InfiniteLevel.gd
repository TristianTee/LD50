extends Node2D

var Platforms := [load("res://Platforms/Boom.tscn"), load("res://Platforms/Bounce.tscn"), load("res://Platforms/Fall.tscn"), load("res://Platforms/Slide.tscn")]
var generationArea := load("res://Scenes/GenerationArea.tscn")

func _ready() -> void:
	generate_area(1000.00, -1000.00)
	if not Settings.muted:
		$Alarm.play()

func _process(_delta: float) -> void:
	if Settings.muted:
		if $Alarm.playing or $Music.playing:
			$Alarm.playing = false 
			$Music.playing = false
	else:
		if not $Alarm.playing and not $Music.playing:
			$Music.play()

func _on_start() -> void:
	if not Settings.muted:
		$Music.play()
	$Alarm.playing = false
	$GOO.start()
	$"4".call('timer_start')
	generate_area(0.00, -1000.00)

func generate_area(height: float, length: float) -> void:
	var maxHeight := height + length
	var optionals = int(length / -100.00)
	var i := 1
	var sinceLastPlaced := 6
	while i <= optionals:
		var left := int(rand_range(0, (3 + 6 - sinceLastPlaced)))
		
		if left < 4:
			var leftPlatform = Platforms[left].instance()
			leftPlatform.position = Vector2( rand_range(130, 500 - leftPlatform.size), rand_range(height - ((float(i)-1.00)*100.00), maxHeight - (float(i) * 100.00)))
			self.add_child(leftPlatform, false)
			sinceLastPlaced = 0
		else:
			sinceLastPlaced += 1			
		var right := int(rand_range(0, (3 + 6 - sinceLastPlaced)))
		if right < 4:
			var rightPlatform = Platforms[right].instance()
			rightPlatform.position = Vector2(rand_range(500, 800 - rightPlatform.size), rand_range(height - ((float(i)-1.00)*100.00), maxHeight - (float(i) * 100.00)))
			self.add_child(rightPlatform, false)
			sinceLastPlaced = 0
		else:
			sinceLastPlaced += 1
		i += 1
	var nextArea = generationArea.instance()
	nextArea.position = Vector2(0.00, height)
	nextArea.connect("body_exited", self, "on_generation_area_exited")

func on_generation_area_exited(body: Node2D):
	$Alarm.play()
	var height = body.global_position
	generate_area(height.y - 2000.00, -1000.00)

func _on_Area2D_body_entered(_body: Node) -> void:
	_on_start()
