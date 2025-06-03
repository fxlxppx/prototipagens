extends Node3D

func _ready():
	if Global.remove_painel:
		if $painel:
			$painel.queue_free()
		if $parede_especial:
			$parede_especial.queue_free()
		Global.remove_painel = false  
		
	
	if Global.saved_player_position != Vector3.ZERO:
		$player.global_transform.origin = Global.saved_player_position
		Global.saved_player_position = Vector3.ZERO 
