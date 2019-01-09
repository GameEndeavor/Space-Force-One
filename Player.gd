extends Node2D

const StandardBullet = preload("res://Bullet/Bullet.tscn")
const ScatterBullet = preload("res://Bullet/ScatterBullet.tscn")

signal shot()

enum UPGRADES {
	NONE, TRIPLE_SHOT, FAST_SHOT
}

var orbit = 0
var offset = 128+8
var move_speed = PI
var move_direction
var target_speed = 0
var shoot_time = 0.3

var active_bullet = StandardBullet

var upgrade_state = NONE
var next_cannon = 0

func _ready():
	$Cannons/Cannon2/AnimationPlayer.play("remove")
	$Cannons/Cannon3/AnimationPlayer.play("remove")
	set_upgrade(NONE)

func _process(delta):
	keyboard_controls(delta)
	
	position.x = cos(orbit) * offset
	position.y = sin(orbit) * offset
	
	rotation = position.angle()

func keyboard_controls(delta):
	# Movement
	move_direction = int(Input.is_action_pressed("move_cw")) - int(Input.is_action_pressed("move_ccw"))
	target_speed = lerp(target_speed, move_direction * move_speed, 0.25)
	orbit += target_speed * delta
	
	# Shoot
	if Input.is_action_pressed("shoot") && $ShootTimer.is_stopped():
		var cannon = $Cannons.get_children()[next_cannon]
		cannon.shoot(active_bullet)
		$ShootTimer.start()
		emit_signal("shot")
		
		if upgrade_state == TRIPLE_SHOT:
			next_cannon = (next_cannon + 1) % $Cannons.get_child_count()

func set_upgrade(upgrade):
	match upgrade:
		NONE:
			$ShootTimer.wait_time = 0.3
			next_cannon = 0
			active_bullet = StandardBullet
		TRIPLE_SHOT:
			$ShootTimer.wait_time = 0.1
			active_bullet = StandardBullet
		FAST_SHOT:
			$ShootTimer.wait_time = 0.2
			next_cannon = 0
			active_bullet = StandardBullet
	
	if upgrade != NONE:
		$UpgradeTimer.start()
	
	if upgrade_state == TRIPLE_SHOT && upgrade != TRIPLE_SHOT:
		$Cannons/Cannon2/AnimationPlayer.play("remove")
		$Cannons/Cannon3/AnimationPlayer.play("remove")
	elif upgrade_state != TRIPLE_SHOT && upgrade == TRIPLE_SHOT:
		$Cannons/Cannon2/AnimationPlayer.play("add")
		$Cannons/Cannon3/AnimationPlayer.play("add")
		
	
	upgrade_state = upgrade

func _on_UpgradeTimer_timeout():
	set_upgrade(NONE)
