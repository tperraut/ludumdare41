extends "res://gui/profile/Bar.gd"

func _on_health_changed(val):
	animate(val)