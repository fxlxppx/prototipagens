extends Node3D
####portal
#extends Area3D
#var trocando = false


#func _on_body_entered(body):
	#if body is CharacterBody3D and not trocando:
		#trocando = true
		#get_tree().change_scene_to_file("res://scenes/terreno.tscn")
####



####tela inicial
#@onready var quit_button = $QuitButton    # Botão para sair do jogo
#@onready var terrain_button = $TerrainButton

#func _ready():
	# Conectando os sinais dos botões com a nova sintaxe
#	start_button.pressed.connect(_on_start_button_pressed)
#	quit_button.pressed.connect(_on_quit_button_pressed)
#	terrain_button.pressed.connect(_on_terrain_button_pressed)

# Função para iniciar a cena principal
#func _on_start_button_pressed():
	# Carregar a cena principal (troque "MainScene" pelo nome da sua cena principal)
#	get_tree().change_scene_to_file("res://scenes/aldeia.tscn")
	
#func _on_terrain_button_pressed():
	# Carregar a cena de opções (troque "OptionsScene" pelo nome da sua cena de opções)
#	get_tree().change_scene_to_file("res://scenes/terreno.tscn")

# Função para fechar o jogo
#func _on_quit_button_pressed():
	# Fecha o jogo
#	get_tree().quit()
###



####inimgigo
#extends Area3D

#@export var original: StandardMaterial3D
#@export var colidido: StandardMaterial3D



#func _on_body_entered(body):
	#if body is CharacterBody3D:
		#$enemy.mesh.material = colidido
		#body.reduzir_energia(5)


#func _on_body_exited(body):
	#if body is CharacterBody3D:
		#$enemy.mesh.material = original
####



####barradevida
#extends CharacterBody3D

#@export var barra_energia: TextureProgressBar
#var energia = 100

#func _process(_delta):
	#barra_energia.value = energia
	
#func reduzir_energia(valor: int):
	#energia = max(energia - valor, 0)
	#barra_energia.value = energia
