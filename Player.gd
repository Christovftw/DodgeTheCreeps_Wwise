extends Area2D
signal hit #sends a signal called 'hit'


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var speed = 400 # how fast the player will move in pixels/sec
var screen_size # size of the game window

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide() # hide the player at the start


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0



func _on_Player_body_entered(_body): #removed body argument
	if PlayerVars.health == 0:
		hide()
		emit_signal("hit")
		$CollisionShape2D.set_deferred("disabled", true)
		print("Player Dead! Health: ", PlayerVars.health)
	else:
		$CollisionShape2D.set_deferred("disabled", true) #turn collisions off
		PlayerVars.health -= 1
		print("Player Hit! PlayerHealth: ", PlayerVars.health)
		PlayerFlash()


func PlayerFlash(): #make the player flash when they lose a life
	var flashcnt = 0
	print("flashing the player")
	while flashcnt < 10:
		$AnimatedSprite.hide() 
		yield(get_tree().create_timer(0.1), "timeout")
		$AnimatedSprite.show()
		yield(get_tree().create_timer(0.1), "timeout")
		flashcnt += 1
		print("flashcnt: ", flashcnt)
	$CollisionShape2D.set_deferred("disabled", false) #turn collisions on


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
