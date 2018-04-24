extends "res://characters/Character.gd"

signal wand_health_changed(val)
signal wand_energy_changed(val)

var ennemi = null
var color = [0.34, 0.34, 0.34]

func _ready():
	randomize()
	var rand_size = spells.size()
	for i in range(6):
		var rand = randi() % rand_size
		spells.append(spells[rand])
		color[rand] = clamp(color[rand] + 0.33, 0, 1)
	$Light.color = Color(color[0], color[1], color[2], 1)
	

func _control(delta):
	weapon.look_at(get_global_mouse_position())
	if !get_tree().paused:
		if ennemi != null:
			if !ennemi.alive:
				ennemi = null
		else:
			velocity = Vector2(speed, 0)
		if Input.is_action_just_pressed("click") && velocity.x == 0:
			cast()			

func _on_DetectRadius_body_entered(body):
	if body.name == "Ennemi":
		ennemi = body
