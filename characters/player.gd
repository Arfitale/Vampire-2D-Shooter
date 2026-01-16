extends CharacterBody2D

signal health_depleted

@export var movement_speed := 600.0
@export var max_health := 10.0
var health: float

@onready var sprite := $HappyBoo
@onready var healthbar := %Healthbar
@onready var weapon := %WeaponSlot

var overlapping_enemies: Array[Node2D] = []

func _ready() -> void:
	health = max_health
	healthbar.max_value = max_health
	healthbar.value = health

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot"):
		_handle_shoot()
	
	if Input.is_action_just_released("shoot"):
		_stop_shoot()

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * movement_speed
	
	if overlapping_enemies.size() > 0 and not $EffectAnimationPlayer.is_playing():
		take_damage(1)
	
	if velocity.length() > 0.0:
		sprite.play_walk_animation()
	else:
		sprite.play_idle_animation()
	
	move_and_slide()

func _handle_shoot() -> void:
	weapon.shoot.emit()

func _stop_shoot() -> void:
	weapon.stop_shoot.emit()

func take_damage(damage: int) -> void:
	health -= damage
	healthbar.value = health
	if health <= 0:
		health_depleted.emit()
	
	$EffectAnimationPlayer.play("hurt")

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		overlapping_enemies.push_back(body)

func _on_hurtbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		overlapping_enemies.pop_front()

func _on_health_depleted() -> void:
	queue_free()
	var smoke_scene := preload("res://smoke_explosion/smoke_explosion.tscn")
	var smoke := smoke_scene.instantiate()
	smoke.global_position = global_position 
	get_parent().add_child(smoke)
	return
