extends Node2D




func spawn_bee(target):
	position.x = target.position.x + 1000
	position.y = 525
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += -133 * delta
	
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print(3)
		body.die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
