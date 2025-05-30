extends MeshInstance3D

@export var velocidade = 2

#cam
@onready var camera = $twist/pitch/Camera3D
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
	# Movimentos básicos
	var input_direction = Vector3.ZERO

	if Input.is_action_pressed("frente"):
		input_direction.z -= 1
	if Input.is_action_pressed("tras"):
		input_direction.z += 1
	if Input.is_action_pressed("direita"):
		input_direction.x += 1
	if Input.is_action_pressed("esquerda"):
		input_direction.x -= 1

	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
		
		input_direction = input_direction.rotated(Vector3.UP, twist_pivot.global_rotation.y)

		position += input_direction * velocidade * delta
		
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
		
