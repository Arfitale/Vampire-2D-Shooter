extends CharacterBody2D

@export var movement_speed := 600.0
@export var health := 10

@onready var sprite := $HappyBoo
@onready var gun := $Gun

var overlapping_enemies: Array[Node2D] = []

func _process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and gun.fire_cooldown <= 0.0:
		_handle_shoot()

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
	gun.shoot()

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free() 
	
	$EffectAnimationPlayer.play("hurt")

func _on_hurtbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		overlapping_enemies.push_back(body)

func _on_hurtbox_body_exited(body: Node2D) -> void:
	if body.is_in_group("Mobs"):
		overlapping_enemies.pop_front()
