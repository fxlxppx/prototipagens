extends Sprite2D

func _process(delta: float) -> void:
	translate(Vector2(0,1) * 1000 * delta)

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.take_damage()
		queue_free()
