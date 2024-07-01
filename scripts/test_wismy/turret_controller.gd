extends StaticBody2D

@onready var stats := $Stats
@onready var cannon := $Cannon
@onready var detection_area := $DetectionArea

@onready var enemies_queue = []

var attacking = false

func _process(delta):
	if not enemies_queue.is_empty():
		var desired_rotation = cannon.global_position.angle_to_point(enemies_queue.front().global_position) + PI/2
		cannon.rotation = lerp(cannon.rotation, desired_rotation, stats.rotation_speed * delta)
		if not attacking:
			if abs(cannon.rotation - desired_rotation) < 0.25:
				self.attack(enemies_queue.front())

func _on_detection_area_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies_queue.push_back(area)

func _on_detection_area_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies_queue.erase(area)

func attack(target):
	if target.has_method("take_damage"):
		attacking = true
		target.take_damage(stats.damage)
		await get_tree().create_timer(stats.attack_speed).timeout
		attacking = false
