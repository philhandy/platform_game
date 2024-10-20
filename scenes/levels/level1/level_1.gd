extends Node2D

const SCREEN_HEIGHT = 500

func _ready():
	%Saw.setup(Vector2(600, 0))


func _process(delta):
	if %Player.alive:
		%Camera2D.position = %Player.position
	var offset = Vector2(int(%Camera2D.position.x) % 64,int(%Camera2D.position.y) % 64)
	%Background.position = %Camera2D.position - offset
	
	if %Player.position.y > %Camera2D.position.y + (SCREEN_HEIGHT / 2):
		get_tree().quit()
