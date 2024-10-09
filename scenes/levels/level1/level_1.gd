extends Node2D


func _ready():
		%Saw.setup(Vector2(600, 0))


func _process(delta):
	var offset = Vector2(int(%Player.position.x) % 64,int(%Player.position.y) % 64)
	%Background.position = %Player.position - offset
