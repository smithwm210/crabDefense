extends Node

func _ready():
	load_main_menu()
	
func load_main_menu():
	get_node("MainMenu/M/VB/NewGame").connect("pressed", on_new_game_pressed)
	get_node("MainMenu/M/VB/Quit").connect("pressed", on_quit_pressed)
	
func on_new_game_pressed():
	$"MainMenu".queue_free()
	var game_scene: Node2D = load("res://scenes/mainScenes/GameScene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	call_deferred('add_child', game_scene)
	
func on_quit_pressed():
	get_tree().quit()

func unload_game(result):
	$GameScene.queue_free()
	var main_menu = load("res://scenes/uiScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
