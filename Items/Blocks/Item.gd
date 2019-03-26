extends KinematicBody2D


export var texture:Texture
var initialPosition:Vector2
export var velocity := Vector2(150,300)
var moving := true

func _ready():
	initialPosition = position
	$SpriteItem.texture = texture

func spawn(delta):
	if(position.y > initialPosition.y - 16):
		position.y -= delta * 15
		return moving
	else:
		return false

func move_item():
		move_and_slide(velocity)
		return moving

func _on_AreaItem_body_entered(body):
	if(body.is_in_group("player")):
		moving = false
		queue_free()

"""export var texture:Texture
export var velocity:Vector2
var initialPosition:Vector2
var animationSpawn:bool
var spawned:bool

func _ready():
	initialPosition = position

func _physics_process(delta):
	if(animationSpawn):
		if(position.y > initialPosition.y - 16 && !spawned):
			position.y -= delta * 15
		else:
			spawned = true
			animationSpawn = false
	if(spawned):
		velocity.x = 150
		velocity.y = 300
		move_and_slide(velocity)

func _on_Block_hit_block(body):
	if(body.is_in_group("player")):
		if(!spawned):
			$SpriteItemBlock.texture = texture
			animationSpawn = true

func _on_Area2D_body_entered(body):
	if(body.is_in_group("player")):
		queue_free()"""


