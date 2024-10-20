extends Node2D

var fire_on

func _ready():
	%AnimatedSprite2D.play("fire_off")
	fire_on = false
	%Area2D.monitoring = false

func _process(delta):
	pass

func _on_timer_timeout():
	if fire_on:
		%AnimatedSprite2D.play("fire_off")
		fire_on = false
		%FireHitbox.disabled = true
	else:
		%AnimatedSprite2D.play("fire_on")
		fire_on = true
		%FireHitbox.disabled = false
