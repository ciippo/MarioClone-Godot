extends KinematicBody2D

var initialPosition:Vector2
var velocity:Vector2
var moving := true

func _ready():
	initialPosition = position

func set_sprite_texture(texture):
	$SpriteItem.texture = texture

func spawn(delta):
	if(position.y > initialPosition.y - 16):
		position.y -= delta * 15
		return moving
	else:
		return false

func move_item():
	move_and_slide(velocity,Vector2(-1,0))
	if(get_slide_count() > 0):
		var lastCollision = get_slide_collision(get_slide_count() - 1)
		var collider = lastCollision.get_collider()
		var direction := 1 if velocity.x > 0 else -1
		if(collider.has_method("world_to_map")):
			var vTile = collider.world_to_map(get_global_position() + Vector2(direction * 17,16))
			if(collider.get_cellv(vTile)==4):
				velocity.x = -velocity.x
	return moving

func _on_AreaItem_body_entered(body):
	if(body.is_in_group("player")):
		moving = false
		queue_free()