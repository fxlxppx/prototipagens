extends CharacterBody2D

var bullet = preload("res://objects/bullet.tscn")
var can_shoot = true

var health = 3

signal player_hit(value)

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("esquerda"):
		velocity.x -= 50
	elif Input.is_action_pressed("direita"):
		velocity.x += 50
	else:
		velocity.x = lerp(velocity.x, 0.0, 0.1)
	
	if Input.is_action_pressed("atirar"):
		if(can_shoot):
			shoot()
			$Timer.start(0.1)
			can_shoot = false

	velocity.x = clamp(velocity.x, -500, 500)
	
	move_and_slide()

func shoot():
	var b = bullet.instantiate()
	get_parent().add_child(b)
	b.global_position = $Marker2D.global_position
	
func take_damage():
	health -= 1
	emit_signal("player_hit", health)
	if health == 0:
		queue_free()

func _on_timer_timeout() -> void:
	$Timer.stop()
	can_shoot = true
