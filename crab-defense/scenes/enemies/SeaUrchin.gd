extends PathFollow2D


var speed = 75
var hp = 100

func _physics_process(delta):
	move(delta)

func move(delta):
	set_progress(get_progress() + speed * delta)
	
func on_hit(damage):
	hp -= damage
	if hp <= 0:
		on_destroy()

func on_destroy():
	self.queue_free()
