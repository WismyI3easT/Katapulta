extends Area2D

@onready var stats := $Stats

func _process(delta):
	self.position += Vector2(stats.speed * delta, 0)

func take_damage(damage):
	print("---> ", stats.health, " to ", stats.health - damage)
	stats.health -= damage

	if stats.health <= 0:
		self.die()

func die():
	queue_free()
