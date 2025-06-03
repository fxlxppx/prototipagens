extends CharacterBody2D

var width = 0

var direction = -1

var bullet = preload("res://objects/enemy_bullet.tscn")

var can_shoot = false

signal enemy_die

func _ready() -> void:
	$Timer.start(2.0)
	width = get_viewport().size.x

func _process(delta: float) -> void:
	if position.x > width - 64:
		direction = -1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y + 100, 1.0)
		
	elif position.x < 64:
		direction = 1
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position:y", position.y + 100, 1.0)
		
	velocity.x = direction * 20000 * delta
	
	if can_shoot:
		shoot()
		$Timer.start(randi() % 5 + 1)
		can_shoot = false
	
	move_and_slide()
	
func shoot():
	var b = bullet.instantiate()
	get_parent().add_child(b)
	b.global_position = $Marker2D.global_position
	
func take_damage():
	emit_signal("enemy_die")
	queue_free()


func _on_timer_timeout() -> void:
	can_shoot = true
	$Timer.stop()
