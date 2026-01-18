extends Area2D

var direction := Vector2.RIGHT
var travelled_distance := 0.0

@export var maximum_distance := 500.0
@export var speed := 1500.0
@export var damage := 2

func _physics_process(delta: float) -> void:
	position += direction * speed * delta	
	travelled_distance += speed * delta
	if travelled_distance >= maximum_distance:
		queue_free()

func set_direction(new_direction: Vector2):
	direction = new_direction

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Mobs") and body.has_method("take_damage"):
		body.take_damage(damage)
	queue_free()
