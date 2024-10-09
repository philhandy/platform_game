extends Node2D

const SPEED = 200

func _ready():
	%Image.play("rotating")
	
func setup(end_pos):
	end_pos += position
	var start_pos = position
	var movement_tween = get_tree().create_tween()
	var time_taken = abs(start_pos.distance_to(end_pos) / SPEED)
	movement_tween.tween_property(self, "position", end_pos, time_taken).set_trans(Tween.TRANS_SINE)
	movement_tween.tween_property(self, "position", start_pos, time_taken).set_trans(Tween.TRANS_SINE)
	movement_tween.set_loops()
