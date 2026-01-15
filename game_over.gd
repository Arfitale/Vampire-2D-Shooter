extends CanvasLayer

signal try_again

func _on_try_again_button_pressed() -> void:
	try_again.emit()
