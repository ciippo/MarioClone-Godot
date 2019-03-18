extends Sprite

var timer
var free = false

func _ready():
	timer = Timer.new()
	timer.connect("timeout", self , "update")
	add_child(timer)
	timer.wait_time = 0.15
	timer.start()

func update():
	if frame < 3:
		frame += 1
	else:
		frame = 0
	print(frame)

func _on_bottomBlock_body_entered(body):
	if body.get_name() == "Player":
		body.velocity.y = 100
		if(!free):
			timer.queue_free()
			frame = 4
			free = true
