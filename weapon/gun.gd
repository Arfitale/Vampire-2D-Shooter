extends Area2D

@export var bullet_scene: PackedScene
@onready var bullet_spawner: Marker2D = $WeaponPivot/Pistol/BulletSpawn
@export var fire_interval := 0.3
@export var auto_aim := false
var fire_cooldown := 0.0
var enemies_in_range : Array[Node2D] = []

func _process(delta: float) -> void:
	fire_cooldown -= delta
	if auto_aim:
		if enemies_in_range.size() > 0:
			var target_enemy = enemies_in_range.front()
			if not target_enemy: return
			look_at(target_enemy.global_position)
		else:
			print(false)
			look_at(get_global_mouse_position())
	else:
		look_at(get_global_mouse_position())

func shoot():
	if not bullet_scene: return
	_spawn_bullet()
	fire_cooldown = fire_interval

func _spawn_bullet():
	var bullet: Area2D = bullet_scene.instantiate()
	get_parent().add_child(bullet)
	bullet.global_position = bullet_spawner.global_position
	bullet.rotation = rotation
	bullet.set_direction(global_transform.x.normalized())

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		enemies_in_range.push_back(body)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		enemies_in_range.pop_front()
