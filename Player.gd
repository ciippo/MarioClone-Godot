extends KinematicBody2D

export var gravity = 900
var velocity = Vector2()
var acceleration = 500
export var max_speed = 300
var jump_position

func _ready():
	pass

func _process(delta):
	update_animation()

func _physics_process(delta):
	#Gravity
	if(!is_on_floor()):
		velocity.y += delta * gravity
	#Axis X
	var modifier = get_acceleration_modifier()
	if(modifier != 0):
		velocity.x += delta * acceleration * modifier;
	else:
		velocity.x = 0
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	# Axis Y
	if(Input.is_action_pressed("jump") && is_on_floor()):
		velocity.y = -700
		jump_position = position
	var min_height_jump = velocity.y > -400 && velocity.y < 0
	var max_height_jump = jump_position != null && jump_position.y - position.y > 250
	if((!Input.is_action_pressed("jump") && min_height_jump) || max_height_jump):
		velocity.y = 0
		jump_position = null
	move_and_slide(velocity,Vector2(0,-1))

# Usado para la animación de sliding
var sliding

# Devuelve el modificador de aceleración. Si el personaje se está desplazando en una dirección y se pulsa la contraria
# se modificará la aceleración base para que sea el doble y la "frenada" del cuerpo no sea tan larga.
func get_acceleration_modifier():
	var modifier = 0
	if(Input.is_action_pressed("ui_right")):
		modifier = 2 if(velocity.x < 0) else 1
	elif(Input.is_action_pressed("ui_left")):
		modifier = -2 if(velocity.x > 0) else -1
	sliding = abs(modifier) == 2
	return modifier

# Actualiza la animación en función del estado del cuerpo.
func update_animation():
	if(!is_on_floor()):
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.animation = "jump"
	elif(sliding):
		$AnimatedSprite.animation = "sliding"
	elif(velocity.x != 0):
		$AnimatedSprite.flip_h = velocity.x < 0
		$AnimatedSprite.animation = "run"
	else:
		$AnimatedSprite.animation = "idle"