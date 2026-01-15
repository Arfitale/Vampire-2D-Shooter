extends Node2D

signal player_died

@onready var spawn_timer := %SpawnTimer
@onready var spawn_path := %SpawnPath

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
	spawn_timer.stop()
