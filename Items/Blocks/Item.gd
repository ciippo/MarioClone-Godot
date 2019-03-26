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