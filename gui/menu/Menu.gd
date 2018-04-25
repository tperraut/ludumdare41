extends Container

signal skiped

func _on_Button_pressed():
	emit_signal("skiped")