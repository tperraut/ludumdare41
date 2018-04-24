extends "res://spells/Spell.gd"

var life = 30

func _on_Spell_body_entered(body):
	return

func take_damage(dmg):
	life -= dmg
	if life < 0:
		_explode()