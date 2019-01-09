extends Node2D

func shoot(Bullet):
	var bullet = Bullet.instance(rotation)
	get_tree().current_scene.add_child(bullet)
	bullet.global_position = $BulletSpawn.global_position
	bullet.rotation = global_rotation
	$AnimationPlayer.play("shoot")
	var rand = randi() % $SFX.get_child_count()
	$SFX.get_children()[rand].play()