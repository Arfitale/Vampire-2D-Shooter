extends CharacterBody2D

var player: Node2D

@export var movement_speed := 400.0
@export var health := 5

func _physics_process(delta: float) -> void:
	if player:
		_chase_player()
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func _chase_player() -> void:
	var player_direction = global_position.direction_to(player.global_position)
	var distance = global_position.distance_to(player.global_position)
	velocity = player_direction * movement_speed

func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_player_detection_body_exited(body: Node2D) -> void:
	player = null

func take_damage(damage: int) -> void:
	health -= damage
	if health <= 0:
		queue_free()
