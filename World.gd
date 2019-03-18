extends TileMap

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var questionBlocks

func _ready():
	questionBlocks = get_used_cells_by_id(1)
	var timer = Timer.new()
	timer.connect("timeout", self , "update")
	add_child(timer)
	timer.wait_time = 0.15
	timer.start()

func update():
	for i in range(questionBlocks.size()):
		if questionBlocks[i].frame < 3:
			questionBlocks[i].frame += 1
		else:
			questionBlocks[i].frame = 0