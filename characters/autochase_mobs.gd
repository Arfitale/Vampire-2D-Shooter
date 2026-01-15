extends CharacterBody2D

signal player_died

var player: Node2D

@export var movement_speed := 400.0
@export var health := 5

func _ready() -> void:
	$Slime.play_walk()
	player = get_node("/root/Game/Player")

func _physics_process(delta: float) -> void:
	if player:
		var player_direction = global_position.direction_to(player.global_position)
		velocity = player_direction * movement_speed
	else:
		velocity = Vector2.ZERO
	move_and_slide()
	
func take_damage(damage: int) -> void:
	health -= damage
	$Slime.play_hurt()
	$Slime/AnimationPlayer.queue("walk")
	if health <= 0:
		queue_free()
		var smoke_scene := preload("res://smoke_explosion/smoke_explosion.tscn")
		var smoke := smoke_scene.instantiate()
		smoke.global_position = global_position 
		get_parent().add_child(smoke)
		return

func _on_player_died() -> void:
	$Slime.play_idle()
