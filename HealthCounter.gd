extends HBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for i in get_child_count():
		get_child(i).visible = PlayerVars.health > i # shows the number of hearts equal to the player health
