extends Area2D

@export var bullet_scene: PackedScene
@onready var bullet_spawner: Marker2D = $WeaponPivot/Pistol/BulletSpawn
@export var fire_interval := 0.3
var fire_cooldown := 0.0

func _process(delta: float) -> void:
	fire_cooldown -= delta
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
