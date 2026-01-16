extends Area2D

signal shoot
signal stop_shoot

@export var selected_weapon: PackedScene
var weapon

func _ready() -> void:
	weapon = selected_weapon.instantiate()
	add_child(weapon)

func _on_shoot() -> void:
	if weapon.has_method("shoot"):
		weapon.shoot()

func _on_stop_shoot() -> void:
	if weapon.has_method("stop_shoot"):
		weapon.stop_shoot()

@export var auto_aim := false
var enemies_in_range : Array[Node2D] = []

func _process(delta: float) -> void:
	if auto_aim:
		if enemies_in_range.size() > 0:
			var target_enemy = enemies_in_range.front()
			if not target_enemy: return
			look_at(target_enemy.global_position)
		else:
			look_at(get_global_mouse_position())
	else:
		look_at(get_global_mouse_position())

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		enemies_in_range.push_back(body)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		enemies_in_range.pop_front()
