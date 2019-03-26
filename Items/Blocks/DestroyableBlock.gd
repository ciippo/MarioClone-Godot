extends "res://Items/Blocks/BaseBlock.gd"

var broken:bool

enum DROPOFF { linear,square,none }
export(DROPOFF) var dropoff = DROPOFF["square"]

func on_hit_block(body):
	.on_hit_block(body)
	if(body.is_in_group("player")):
		$SpriteBlock.queue_free()
		$ShapeBlock.queue_free()
		$BottomBlock.queue_free()
		$Particles2D.emitting = true
		broken = true

func _process(delta):
	if(!$Particles2D.is_emitting() && broken):
		queue_free()