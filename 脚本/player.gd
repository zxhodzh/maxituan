extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -1050.0
#var direction = Vector2.ZERO
signal go
signal back
signal gameover
signal gamepass
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var jump_timer: Timer = $JumpTimer



var left_border = 0
var right_border = 13056


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		jump_timer.start()



func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 2
		
	if jump_timer.time_left > 0 and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_timer.stop()
		$AudioStreamPlayer.play()
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	_up_anim(direction)
	if direction == 1:
		go.emit()
	if direction == -1:
		back.emit()

	move_and_slide()
	
func _up_anim(direction):
	if is_on_floor():
		if is_zero_approx(direction):
			animated_sprite.play("idle")
		if direction > 0:
			animated_sprite.play("run")
		if direction < 0:
			animated_sprite.play("back")
	else:
		animated_sprite.play("jump")
func _process(delta: float) -> void:
	global_position.x = clamp(global_position.x, left_border+280, right_border-150)
func die():
	$AudioStreamPlayer2.play()
	gameover.emit()
	animated_sprite.play("dead")
func happy():
	$AudioStreamPlayer4.play()
	gamepass.emit()
	animated_sprite.play("happy")
	

#func _on_area_2d_area_entered(area: Area2D) -> void:
	#if area.name == "FireArea2D":
		#print(1)
		#
		##$AnimatedSprite2D.stop()
		##$AnimatedSprite2D.animation = "dead"
		##animated_sprite.play("dead")
		#animated_sprite.play("dead")
		##get_node("CollisionShape2D").queue_free()
		#gamepass.emit()
#func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.name == "Fire":
		#print(3)
		#animated_sprite.play("dead")
		#gamepass.emit()
		




func _on_audio_stream_player_2_finished() -> void:
	$AudioStreamPlayer3.play()
