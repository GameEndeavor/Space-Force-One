extends Node

const LargeAsteroid = preload("res://Asteroid/LargeAsteroid00.tscn")

func _spawn_asteroid():
	var asteroid = LargeAsteroid.instance()
	get_parent().add_child(asteroid)
	asteroid.random_spawn()
	

func _on_Timer_timeout():
	_spawn_asteroid()
