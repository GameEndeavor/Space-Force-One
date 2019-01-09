extends Node2D

signal damaged()
signal destroyed()

var health = 100

func _ready():
	randomize()
	for camera in get_tree().get_nodes_in_group("camera"):
		connect("damaged", camera.get_node("Shaker"), "start", [0.3, 15, 16, 4])
		connect("destroyed", camera.get_node("Shaker"), "start", [4.0, 15, 16, 5])

func damage(source, amount):
	health = max(health - amount, 0)
	emit_signal("damaged")
	$SFX.play()
	if health == 0:
		destroy()

func destroy():
	emit_signal("destroyed")
#	queue_free()

func _on_HitBox_area_entered(area):
	$AnimationPlayer.play("damage")
	
func _on_Shaker_shake_stopped():
	$AnimationPlayer.play("rest")
