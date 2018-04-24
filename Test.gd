extends Node

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = !get_tree().paused
		$Popup.popup()

func _on_cast(spell, pos, dir):
	var s = spell.instance()
	add_child(s)
	s.cast(pos, dir)