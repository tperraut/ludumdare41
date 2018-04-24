extends Area2D

export(int) var speed = 10
export(int) var damage = 10
export(float) var lifetime = 5 

var velocity = Vector2()

func _ready():
	$Sprite.playing = true

func cast(pos, dir):
	position = pos
	rotation = dir.angle()
	$LifeTime.wait_time = lifetime
	velocity = dir * speed
	$LifeTime.start()

func _process(delta):
	position += velocity * delta

func _explode():
	velocity = Vector2()
	$Sprite.visible = false
	$Particule.emitting = true
	yield(get_tree().create_timer($Particule.lifetime), "timeout")
	queue_free()

func _on_LifeTime_timeout():
	_explode()
	
func _on_Spell_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		_explode()