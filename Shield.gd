extends Node2D



func _on_Area2D_area_entered(area):
	var entity = area.get_parent()
	if entity.velocity < 0:
		entity.queue_free()
		$AnimationPlayer.play("activate")
