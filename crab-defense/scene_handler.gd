extends Node

func _ready():
	get_node("MainMenu/M/VB/NewGame").connect("pressed", on_new_game_pressed)
	get_node("MainMenu/M/VB/Quit").connect("pressed", on_quit_pressed)
	
func on_new_game_pressed():
	get_node("MainMenu").queue_free()
	var game_scene = load("res://scenes/mainScenes/GameScene.tscn").instantiate()
	add_child(game_scene)
	
func on_quit_pressed():
	get_tree().quit()
