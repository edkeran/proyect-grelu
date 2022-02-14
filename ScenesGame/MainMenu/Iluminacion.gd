extends Light2D

const TIME_SCALE = 0.3
const MAX_ENERGY = 1.3
var current_illumiation = MAX_ENERGY
var incVal = true

func _process(delta):
	if(current_illumiation >= MAX_ENERGY):
		incVal = false
	if(current_illumiation <= 0.3):
		incVal = true
	if(incVal):
		current_illumiation+= delta * TIME_SCALE
	else:
		current_illumiation-= delta * TIME_SCALE
	self.energy= current_illumiation
