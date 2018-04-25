extends Popup

func _on_Menu_skiped():
	hide()
	get_tree().paused = false