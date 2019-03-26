extends StaticBody2D

signal hit_block

func _on_BottomBlock_body_entered(body):
	emit_signal("hit_block", body)
	on_hit_block(body)

func on_hit_block(body):
	if(body.is_in_group("player")):
		body.velocity.y = 100