extends CharacterBody2D

@export var movement_speed := 600.0
@onready var sprite := $HappyBoo

func _physics_process(_delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * movement_speed
	
	if velocity.length() > 0.0:
		sprite.play_walk_animation()
	else:
		sprite.play_idle_animation()
	
	move_and_slide()
