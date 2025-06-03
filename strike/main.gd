extends Node2D

var enemy = preload("res://objects/enemy.tscn")

var score = 0

func _ready() -> void:
	$Timer.start(2.0)

func _on_timer_timeout() -> void:
	var inst = enemy.instantiate()
	add_child(inst)
	
	inst.connect("enemy_die", _on_enemy_die)
	
	var choice = randi() % 2
	if choice == 1:
		inst.position = $LeftSpawnPosition.position
	else:
		inst.position = $RightSpawnPosition.position
		
	$Timer.start(randi() % 4)


func _on_player_player_hit(value: Variant) -> void:
	$CanvasLayer/HP.text = "HP: " + str(value)

func _on_enemy_die():
	score += 1
	$CanvasLayer/Score.text = "Score: " + str(score)
	
	if score >= 10:
		Global.remove_painel = true
		get_tree().change_scene_to_file("res://scenes/world.tscn")
