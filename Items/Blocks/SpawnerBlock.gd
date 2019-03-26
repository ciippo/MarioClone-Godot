extends "res://Items/Blocks/BaseBlock.gd"

var initialPosition:Vector2
var animationSpawn:bool
var spawned:bool
var movingItem := true
export var itemTexture:Texture
export var itemVelocity := Vector2(150,300)

func _ready():
	initialPosition = $Item.position
	$Item.velocity = itemVelocity
	$Item.set_sprite_texture(itemTexture)

func _physics_process(delta):
	if(animationSpawn):
		if(!$Item.spawn(delta)):
			spawned = true
			animationSpawn = false
	if(spawned && movingItem):
		movingItem = $Item.move_item()

func on_hit_block(body):
	.on_hit_block(body)
	if(body.is_in_group("player")):
		if(!spawned):
			animationSpawn = true