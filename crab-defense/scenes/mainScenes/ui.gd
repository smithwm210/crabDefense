extends CanvasLayer

@onready var hp_bar = get_node("HUD/InfoBar/H/HP")
#@onready var hp_bar_tween = $HUD/InfoBar/H/HP.create_tween().set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)

#hp_bar_tween.tween_property($HUD/InfoBar/H/HP, "value", base_health, 0.1).from(hp_bar.value)

func set_tower_preview(tower_type, mouse_position):
	var drag_tower = load("res://scenes/turrets/" + tower_type + ".tscn").instantiate()
	drag_tower.set_name("DragTower")
	drag_tower.modulate = Color("ad54ff3c")
	
	var range_texture = Sprite2D.new()
	range_texture.position = Vector2(0,0)
	var scaling = GameData.tower_data[tower_type]["range"] / 600.0
	range_texture.scale = Vector2(scaling, scaling)
	var texture = load("res://assets/UI/range_overlay.png")
	range_texture.texture = texture
	range_texture.modulate = Color("ad54ff3c")
	
	var control = Control.new()
	control.add_child(drag_tower, true)
	control.add_child(range_texture, true)
	control.position = mouse_position
	control.set_name("TowerPreview")
	add_child(control, true)
	move_child(get_node("TowerPreview"), 0)

func update_tower_preview(new_position, color):
	get_node("TowerPreview").set_position(new_position)
	if get_node("TowerPreview/DragTower").modulate != Color(color):
		get_node("TowerPreview/DragTower").modulate = Color(color)
		get_node("TowerPreview/Sprite2D").modulate = Color(color)

##
## Game Control Functions
##

func _on_pause_play_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if get_tree().is_paused():
		get_tree().paused = false
	elif get_parent().current_wave == 0:
		get_parent().start_next_wave()
	else:
		get_tree().paused = true

func _on_speed_up_pressed():
	if get_parent().build_mode:
		get_parent().cancel_build_mode()
	if Engine.get_time_scale() == 2.0:
		Engine.set_time_scale(1.0)
	else:
		Engine.set_time_scale(2.0)
		


func update_health_bar(base_health):
	var hp_bar_tween = hp_bar.create_tween()
	hp_bar_tween.tween_property(hp_bar, "value", base_health, 0.1)
	if base_health >= 60:
		hp_bar.tint_progress = Color("00bb28") # Green
	elif base_health <= 60 and base_health >= 25:
		hp_bar.tint_progress = Color("e1be32") # Orange
	else:
		hp_bar.tint_progress = Color("e11e1e") # Red
