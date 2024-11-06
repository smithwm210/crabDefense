extends Node2D

var map_node

var build_mode = false
var build_valid = false
var build_location
var build_type

var current_wave = 0
var enemies_in_wave = 0

func _ready():
	map_node = get_node("Map1")
	
	for i in get_tree().get_nodes_in_group("build_buttons"):
		i.connect("pressed", initiate_build_mode(i.get_name()))
		#if bug, try i.get_name()
	
	start_next_wave()

##
## Building Turrets
##

func _unhandled_input(event):
	pass

func initiate_build_mode(tower_type):
	pass

func update_tower_preview():
	pass

func cancel_build_model():
	pass

func verify_and_build():
	pass


##
## Wave Functions
##

func start_next_wave():
	var wave_data = retrieve_wave_data()
	await get_tree().create_timer(0.5).timeout
	spawn_enemies(wave_data)
	
func retrieve_wave_data():
	var wave_data = [["SeaUrchin",0.7],["SeaUrchin",0.1]]
	current_wave += 1
	print("We are on wave ", current_wave)
	enemies_in_wave = wave_data.size()
	return wave_data

func spawn_enemies(wave_data):
	for i in wave_data:
		var new_enemy = load("res://scenes/enemies/"+i[0]+".tscn").instantiate()
		map_node.get_node("path").add_child(new_enemy, true)
		print("i spawned!")
		await get_tree().create_timer(i[1]).timeout
		
