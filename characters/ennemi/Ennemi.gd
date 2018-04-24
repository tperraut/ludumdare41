extends "res://characters/Character.gd"

var target = null

func _control(delta):
	if target != null:
		if !target.alive:
			target = null
		else:
			weapon.look_at(target.global_position)
			cast()
	
func _on_DetectRadius_body_entered(body):
	if body.name == "Magician":
		target = body
		