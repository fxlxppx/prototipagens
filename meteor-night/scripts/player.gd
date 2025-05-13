extends MeshInstance3D
#cores
@onready var normal = preload("res://materials/player.tres")
@onready var no_dash = preload("res://materials/dash_color.tres")

var normalmente = true

#velocidade/dash
@export var velocidade = 2
@export var velocidade_corrida = velocidade * 5
@export var duracao_corrida = 2
@export var cooldown_corrida = 5

var tempo_cooldown = 0.0
var tempo_corrida = 0.0
var correndo = false

#cam
@onready var twist_pivot = $twist
@onready var pitch_pivot = $twist/pitch

var mouse_sens = 0.001
var twist_input = 0
var pitch_input = 0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# Lógica do dash
	var speed = velocidade
	
	if Input.is_action_pressed("corrida-dash") and not correndo and tempo_cooldown <= 0:
		correndo = true
		tempo_corrida = duracao_corrida
		tempo_cooldown = cooldown_corrida
		material_override = no_dash
		normalmente = false
		
	if correndo:
		speed = velocidade_corrida
		tempo_corrida -= delta
		if tempo_corrida <= 0.0:
			correndo = false
			material_override = normal
			normalmente = true
			
	if tempo_cooldown > 0.0:
		tempo_cooldown -= delta
		
	# Movimentos básicos
	if Input.is_action_pressed("frente"):
		position.z -= speed * delta
		
	if Input.is_action_pressed("tras"):
		position.z += speed * delta
		
	if Input.is_action_pressed("direita"):
		position.x += speed * delta
		
	if Input.is_action_pressed("esquerda"):
		position.x -= speed * delta
		
	#cam stuff
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x,deg_to_rad(-30),deg_to_rad(30))
	twist_input = 0.0
	pitch_input = 0.0
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sens
			pitch_input = -event.relative.y * mouse_sens
		
