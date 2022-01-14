extends Node



func _ready():
	#load the wwise sound banks
	Wwise.load_bank("Init")
	Wwise.load_bank("SFX")
	Wwise.load_bank("Music")


	# register the wwise listener
	Wwise.register_listener(self)
	# Wwise.set_3d_position(self, self.get_global_transform())

	# start the music
	Wwise.post_event("MusicStart", self)
	
func _process(_delta):
	# Send the score to the Wwise RTPC PlayerScore every frame
	Wwise.set_rtpc("PlayerScore", PlayerVars.score, self)
