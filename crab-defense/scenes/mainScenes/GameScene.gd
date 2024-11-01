extends Node2D

var map_node

var current_wave = 0
var enemies_in_wave = 0

func _ready():
	map_node = get_node("Map1")
	start_next_wave()

##
## Wave Functions
##

func start_next_wave():
	var wave_data = retrieve_wave_data()
	get_tree().create_timer(0.2)
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["BlueTank",1],["BlueTank",0.2]]
	current_wave += 1
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://scenes/enemies/"+i[0]+".tscn").instantiate()
		map_node.get_node("path").add_child(new_enemy, true)
		get_tree().create_timer(i[1])
