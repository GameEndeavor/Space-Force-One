extends Node2D

var spawn_timer_end = 0.75
var difficulty_duration = 120
var score = 0

onready var score_value = $CanvasLayer/Interface/Score/HBoxContainer/ScoreValue
onready var score_tween = $CanvasLayer/Interface/Score/HBoxContainer/ScoreTween

func _ready():
	var spawn_timer = $AsteroidSpawner/SpawnTimer
	$DifficultyTween.interpolate_property(spawn_timer, "wait_time", spawn_timer.wait_time, spawn_timer_end, difficulty_duration, Tween.TRANS_QUAD, Tween.EASE_IN)
	$DifficultyTween.start()

func _on_World_destroyed():
	if $CanvasLayer/Effects/AnimationPlayer.current_animation != "game_over":
		$CanvasLayer/Interface/Container/VBoxContainer/EndScoreValue.text = str(int(score))
		$CanvasLayer/Effects/AnimationPlayer.play("game_over")

func _on_Asteroid_destroyed(value = 30):
	var old_score = score
	score += value
	var score_value = $CanvasLayer/Interface/Score/HBoxContainer/ScoreValue
	var score_tween = $CanvasLayer/Interface/Score/HBoxContainer/ScoreTween
	score_tween.interpolate_method(self, "_score_tween_method", int(score_value.text), score, 0.2, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	score_tween.start()

func _score_tween_method(value):
	score_value.text = str(int(value))

func _reset():
	get_tree().reload_current_scene()