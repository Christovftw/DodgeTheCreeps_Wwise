extends Node



func _ready():
	#load the wwise sound banks
	Wwise.load_bank("Init")
	Wwise.load_bank("SFX")


	#register the wwise listener
	Wwise.register_listener(self)
#	Wwise.set_3d_position(self, self.get_global_transform())

