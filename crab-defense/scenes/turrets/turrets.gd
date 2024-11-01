extends Node2D


var type
var enemy_array = [1]
#var built = false
var enemy
var readied = true


func _physics_process(delta):
	if enemy_array.size() != 0:
		enemy = enemy_array[0]
		#select_enemy()
		turn()
		if readied:
			fire()
	else:
		enemy = null


func turn():
	#get_node("Turret").look_at(enemy.position)
	var enemy_position = get_global_mouse_position()
	get_node("Turret").look_at(enemy_position)

#func select_enemy():
	#var enemy_progress_array = []
	#for i in enemy_array:
		#enemy_progress_array.append(i.offset)
	#var max_offset = enemy_progress_array.max()
	#var enemy_index = enemy_progress_array.find(max_offset)
	#enemy = enemy_array[enemy_index]

func fire():
	readied = false
	
	#enemy.on_hit(GameData.tower_data["GunT1"]["damage"])
	get_tree().create_timer(1)
	readied = true
	
