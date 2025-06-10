extends CharacterBody3D

@export var velocidade = 4.0
@export var jump_force = 10.0
@export var gravity = 30.0

var fall_timer = 0.0
var falling = false
const FALL_THRESHOLD = 2.5

@onready var camera = $gato_body/twist/pitch/SpringArm3D/Camera3D
@onready var twist_pivot = $gato_body/twist
@onready var pitch_pivot = $gato_body/twist/pitch

var mouse_sens = 0.001
var twist_input = 0.0
var pitch_input = 0.0

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

	# MOVIMENTO
	var input_direction = Vector3.ZERO

	if Input.is_action_pressed("Movimentacao_para_frente"):
		input_direction.z -= 1
	if Input.is_action_pressed("Movimentacao_para_tras"):
		input_direction.z += 1
	if Input.is_action_pressed("Movimentacao_para_a_direita"):
		input_direction.x += 1
	if Input.is_action_pressed("Movimentacao_para_a_esquerda"):
		input_direction.x -= 1

	if input_direction != Vector3.ZERO:
		input_direction = input_direction.normalized()
		input_direction = input_direction.rotated(Vector3.UP, twist_pivot.global_rotation.y)
	
	velocity.x = input_direction.x * velocidade
	velocity.z = input_direction.z * velocidade

	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody3D:
			var direction = (collision.get_position() - global_position).normalized()
			if velocity.dot(direction) > 0.1:  
				if collision.get_collider().linear_velocity.length() < 2.0:
					collision.get_collider().apply_central_impulse(direction * 1)
			
	# GRAVIDADE E QUEDA
	if not is_on_floor():
		velocity.y -= gravity * delta

		if not falling:
			falling = true
			fall_timer = 0.0
		else:
			fall_timer += delta
			if fall_timer >= FALL_THRESHOLD:
				get_tree().quit() 
	else:
		falling = false
		fall_timer = 0.0

# PULO
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_force

	# Move com física
	move_and_slide()

	# CÂMERA
	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, deg_to_rad(-40), deg_to_rad(30))
	twist_input = 0.0
	pitch_input = 0.0

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			twist_input = -event.relative.x * mouse_sens
			pitch_input = -event.relative.y * mouse_sens
