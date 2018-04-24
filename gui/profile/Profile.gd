extends TextureRect

func _on_health_changed(val):
	$Health.animate(val)

func _on_energy_changed(val):
	$Energy.animate(val)