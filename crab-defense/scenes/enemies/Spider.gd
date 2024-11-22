extends PathFollow2D


signal base_damage(damage)
signal enemy_died

var speed = 60
var hp = 150

@onready var health_bar = get_node("HealthBar")
@onready var impact_area = get_node("Impact")
var projectile_impact = preload("res://scenes/supportScenes/projectile_impact.tscn")

func _ready():
	health_bar.max_value = hp
	health_bar.value = hp
	get_node("HealthBar").set_as_top_level(true) #disabled because health bars were not working

func _physics_process(delta):
	if progress_ratio == 1.0:
		emit_signal("base_damage", 21)
		enemy_died.emit()
		queue_free()
	move(delta)

func move(delta):
	set_progress(get_progress() + speed * delta)
	health_bar.set_position(global_position + Vector2(-30,-40))
		
	
func on_hit(damage):
	impact()
	hp -= damage
	health_bar.value = hp
	if hp <= 0:
		on_destroy()

func impact():
	randomize()
	var x_pos = randi() %21
	var y_pos = randi() %21
	var impact_location = Vector2(x_pos, y_pos)
	var new_impact = projectile_impact.instantiate()
	new_impact.position = impact_location
	impact_area.add_child(new_impact)

func on_destroy():
	get_node("CharacterBody2D/Sprite2D").queue_free()
	enemy_died.emit()
	self.queue_free()