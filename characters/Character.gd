extends KinematicBody2D

signal dead
signal health_changed(val)
signal cast(spell, pos, dir)

export(Array) var spells
export(int) var speed = 10
export(int) var detect_radius = 500
export(float) var health = 100
export(PackedScene) var weapon

var velocity = Vector2()
var alive = true
var can_cast = true

func _ready():
	$Sprite.playing = true
	if weapon != null:
		weapon = weapon.instance()
		$WeaponPosition.add_child(weapon)
	$DetectRadius/CollisionShape2D.shape.radius = detect_radius / scale.x

func _control(delta):
	pass

func _physics_process(delta):
	if not alive:
		return
	_control(delta)
	move_and_slide(velocity)
	velocity = Vector2()

func _on_CastTimer_timeout():
	can_cast = true

func _fade(val):
	$Sprite.modulate.a = val

func _on_dead():
	$Sprite.playing = false
	alive = false	
	$Tween.interpolate_method(
		self,
		"_fade",
		1,
		0,
		1,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	$Tween.start()
	yield($Tween, "tween_completed")
	queue_free()

func take_damage(dmg):
	health = clamp(health - dmg, 0, 100)
	emit_signal("health_changed", health)	
	if health == 0:
		emit_signal("dead")

func cast():
	if can_cast:
		can_cast = false
		$CastTimer.start()
		var dir = Vector2(1, 0).rotated(weapon.global_rotation)
		emit_signal(
			"cast",
			spells[randi() % spells.size()],
			weapon.get_muzzle().global_position,
			dir
		)