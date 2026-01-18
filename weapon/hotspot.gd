extends Node2D

func shoot() -> void:
	$RayCast2D.is_casting = true
	
func stop_shoot() -> void:
	$RayCast2D.is_casting = false
