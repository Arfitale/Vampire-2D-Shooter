extends ProgressBar

signal low_health

func _on_value_changed(value: float) -> void:
	if value < 3:
		low_health.emit()

func _on_low_health() -> void:
	var fill := StyleBoxFlat.new()
	fill.bg_color = Color.RED
	add_theme_stylebox_override("fill", fill) 
