extends StaticBody2D

@onready var cannon := $Cannon
@onready var detection_area := $DetectionArea

@onready var enemies_queue = []

func _process(delta):
	if not enemies_queue.is_empty():
		var desired_rotation = cannon.global_position.angle_to_point(enemies_queue.front().global_position) + PI/2
		cannon.rotation = lerp(cannon.rotation, desired_rotation, 10 * delta)

func _on_detection_area_area_entered(area):
	if area.is_in_group("Enemy"):
		enemies_queue.push_back(area)

func _on_detection_area_area_exited(area):
	if area.is_in_group("Enemy"):
		enemies_queue.pop_front()
