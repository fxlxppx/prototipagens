extends Area3D


func _on_body_entered(body):
	Global.saved_player_position = body.global_transform.origin
	get_tree().change_scene_to_file("res://scenes/node_2d.tscn")
