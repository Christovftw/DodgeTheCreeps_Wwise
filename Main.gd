extends Node


export (PackedScene) var Mob

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if $StartTimer.get_time_left() > 0:
#		print($StartTimer.get_time_left())
#
	


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
#	print("game over")
	$HUD.show_game_over()
	get_tree().call_group("mobs", "queue_free")
	$Music.stop()
	$DeathSound.play()
	
func new_game():
#	print("starting new game")
	PlayerVars.score = 0
	$Player.start($StartPosition.position)
#	print("starting starttimer")
	$StartTimer.start()
	$HUD.update_score(PlayerVars.score)
	$HUD.show_message("Get Ready")
#	$Music.play()

func _on_StartTimer_timeout():
#	print("starttimer timeout")
	$MobTimer.start()
#	print("mobtime started")
	$ScoreTimer.start()
#	print("scoretime started")
	
	
func _on_ScoreTimer_timeout():
	PlayerVars.score += 1
	$HUD.update_score(PlayerVars.score)
	$Background.color = Color(rand_range(0,1), rand_range(0,1), rand_range(0,1), rand_range(0.5,1))
#	print($Background.color)
	
func _on_MobTimer_timeout():
#	print("spawning mob")
	$MobPath/MobSpawnLocation.offset = randi() #choose random location on path2d
	
	var mob = Mob.instance()
	add_child(mob) #creates an instance of mob and adds to the scene
	
	var direction = $MobPath/MobSpawnLocation.rotation + PI / 2 #set the mobs direction perpendicular to the path direction
	
	mob.position = $MobPath/MobSpawnLocation.position #set the mobs position to a random location
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction #add some randomness to the direction
	
	mob.linear_velocity = Vector2(rand_range(mob.min_speed, mob.max_speed), 0)
	mob.linear_velocity = mob.linear_velocity.rotated(direction) #set the velocity speed and direction
