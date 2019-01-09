extends Node

const TripleRocket = preload("res://Rockets/TripleRocket.tscn")
const FastRocket = preload("res://Rockets/FastRocket.tscn")

var rockets = [TripleRocket, FastRocket]

func _spawn_rocket():
	var rand = randi() % rockets.size()
	var rocket = rockets[rand].instance()
	add_child(rocket)
	rocket.rotation = rand_range(-PI, PI)

func _on_RocketTimer_timeout():
	_spawn_rocket()
