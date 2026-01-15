extends Node2D

signal player_died

@onready var spawn_timer := %SpawnTimer
@onready var spawn_path := %SpawnPath
@onready var game_over := %GameOver

func _spawn_mobs() -> void:
	var new_mobs: Node2D = preload("res://characters/autochase_mobs.tscn").instantiate()
	var random_position := randf()
	spawn_path.progress_ratio = random_position
	new_mobs.global_position = spawn_path.global_position
	player_died.connect(new_mobs._on_player_died)
	add_child(new_mobs)

func _on_spawn_timer_timeout() -> void:
	_spawn_mobs()

func _on_player_health_depleted() -> void:
	player_died.emit()

func _on_player_died() -> void:
	spawn_timer.stop()
	game_over.visible = true

func _on_game_over_try_again() -> void:
	get_tree().reload_current_scene()
