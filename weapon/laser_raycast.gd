@tool
extends RayCast2D

@onready var line2d := $Line2D

@export var cast_speed := 99999.0
@export var cast_range := 9000.0
@export var start_distance := 20.0

# Particle
@onready var emit_particles := %EmitParticles
@onready var beam_particles := %BeamParticles

var is_casting := false : set = set_is_casting

func _ready() -> void:
	set_is_casting(is_casting)
	_handle_casting_update()

func _physics_process(delta: float) -> void:
	target_position.x = move_toward(target_position.x, cast_range, cast_speed * delta)

	var laser_start_position = line2d.points[0]
	var laser_end_position := target_position
	force_raycast_update()
	beam_particles.position = laser_start_position + (laser_end_position - laser_start_position) * 0.5
	beam_particles.process_material.emission_box_extents.x = laser_end_position.distance_to(laser_start_position) * 0.5
	
	if is_colliding():
		laser_end_position = to_local(get_collision_point())
	line2d.points[1] = laser_end_position
	

func set_is_casting(new_value) -> void:
	if is_casting == new_value: return
	is_casting = new_value
	_handle_casting_update()


func _handle_casting_update() -> void:
	set_physics_process(is_casting)
	emit_particles.emitting = is_casting
	beam_particles.emitting = is_casting
	
	if is_casting:
		line2d.points[0].x = start_distance
		line2d.points[1].x = start_distance
	else:
		target_position.x = 0.0
		line2d.points[1] = target_position
		line2d.points[0].x = 0
