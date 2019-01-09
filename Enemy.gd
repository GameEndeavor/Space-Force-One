extends Node2D

onready var player = get_node("/root/Game/World/Player")
onready var gun_pos = $GunAnchor

var move_speed = 4
var max_distance = 256

func _process(delta):
	if player != null:
		var distance = position.distance_to(player.position)
		#var distance = (player.position - position)
		if distance > max_distance:
			position += (player.position - position).normalized() * move_speed
	
	gun_pos.rotation = (player.position - position).angle()