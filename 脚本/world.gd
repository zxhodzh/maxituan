extends Node2D

var can_shoot = true
var can_shoot2 = true
@export var fire_q : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = false
	var a = fire_q.instantiate()
	$FireQ.add_child(a)
			###a.spawn_bee($Player)
	##var randint = randi_range(1152 , 1728)
	a.position = Vector2(1152 , 525)
	$Timer2.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if can_shoot:
		#shoot()
	pass



	
	






	
#func shoot():
	#var a = fire_q.instantiate()
	#$FireQ.add_child(a)
	#var randint = randi_range(1152 , 1728)
	#a.position = Vector2($Player.position.x + 1300 , 325)
	#can_shoot = false
	#$Timer2.start()
	#$Timer2.wait_time = randf_range(3, 5)
		

















func _on_timer_timeout() -> void:
	can_shoot = true
	


func _on_timer_2_timeout() -> void:
	can_shoot2 = true

func _on_player_go() -> void:
	await get_tree().create_timer(0.5).timeout
	if can_shoot and can_shoot2:
		var a = fire_q.instantiate()
		$FireQ.add_child(a)
		var randint = randi_range(1152 , 1728)
		a.position = Vector2($Player.position.x + randint , 525)
		
		
		can_shoot = false
		$FireQ/Timer.start()
		$FireQ/Timer.wait_time = randf_range(2.5, 3)


func _on_player_back() -> void:
	can_shoot2 = false
	$Timer2.start()


func _on_player_gameover() -> void:
	get_tree().paused = true
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://场景/ready.tscn")


func _on_player_gamepass() -> void:
	$Node2D2/Guanzhong.play()
	$Node2D2/Guanzhong2.play()
	$Node2D2/Guanzhong3.play()
	get_tree().paused = true
	await get_tree().create_timer(4).timeout
	get_tree().change_scene_to_file("res://场景/over.tscn")
