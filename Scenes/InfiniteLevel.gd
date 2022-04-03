extends Node2D

export var generationLength := -1000.00
var Platforms := [load("res://Platforms/Boom.tscn"), load("res://Platforms/Bounce.tscn"), load("res://Platforms/Fall.tscn"), load("res://Platforms/Slide.tscn")]
var nextGeneration := 800.00

func _ready() -> void:
	generate_area()
	$GenerationTimer.start()
	if not Settings.muted:
		$Alarm.play()
	_on_start()

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

func generate_area() -> void:
	var maxHeight := nextGeneration + generationLength
	var optionals = int(generationLength / -100.00)
	var i := 1
	var sinceLastPlaced := 0
	var leftBound = 130 if(nextGeneration > -4000) else 0
	var rightBound = 800 if(nextGeneration > -4000) else 1024
	var heightBias = (maxHeight / -1000) 
	var bias := 0
	while i <= optionals:
		
		bias = heightBias - sinceLastPlaced
		if bias < 0:
			bias = 0
		var left := int(rand_range(0, (3 + bias)))
		
		if left < 4:
			var leftPlatform = Platforms[left].instance()
			leftPlatform.position = Vector2( rand_range(leftBound, 500 - leftPlatform.size), rand_range(nextGeneration - ((float(i)-1.00)*100.00), maxHeight - (float(i) * 100.00)))
			self.add_child(leftPlatform, false)
			sinceLastPlaced = 0
		else:
			sinceLastPlaced += 1
			
		bias = heightBias - sinceLastPlaced
		if bias < 0:
			bias = 0
			
		var right := int(rand_range(0, (3 + 6 - sinceLastPlaced)))
		if right < 4:
			var rightPlatform = Platforms[right].instance()
			rightPlatform.position = Vector2(rand_range(500, rightBound - rightPlatform.size), rand_range(nextGeneration - ((float(i)-1.00)*100.00), maxHeight - (float(i) * 100.00)))
			self.add_child(rightPlatform, false)
			sinceLastPlaced = 0
		else:
			sinceLastPlaced += 1
		i += 1
	nextGeneration = maxHeight

func _on_Area2D_body_entered(_body: Node) -> void:
	_on_start()


func _on_GenerationTimer_timeout() -> void:
	generate_area()


func _on_Freedom_area_entered(area: Area2D) -> void:
	area.scale.x = 2
