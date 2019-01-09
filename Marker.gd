extends Node2D

const MAX_WIDTH = 1280/2
const MAX_HEIGHT = 720/2

onready var parent = get_parent()

func _process(delta):
	rotation = (parent.position.angle())
	global_position.x = clamp(parent.position.x, -MAX_WIDTH, MAX_WIDTH)
	global_position.y = clamp(parent.position.y, -MAX_HEIGHT, MAX_HEIGHT)