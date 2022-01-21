extends Camera2D

export var defaultZoomX = 1
export var defaultZoomY = 1

export var maxZoomCloseX = 0.4
export var maxZoomCloseY = 0.13

export var Smooth = 0.02
var positionFinal = Vector2(100, 200)

var isZooming = false
signal animation_completed

func _ready():
	self.zoom.x = defaultZoomX
	self.zoom.y = defaultZoomY

func _process(delta):
	if(zoom.x <= maxZoomCloseX or zoom.y <= maxZoomCloseY):
		isZooming = false
		emit_signal("animation_completed")
	if(isZooming and (zoom.x > maxZoomCloseX or zoom.y > maxZoomCloseY)):
		animationZoom(delta)
	

func animationZoom(delta):
	var newZoom = Vector2(maxZoomCloseX,maxZoomCloseY)
	zoom = zoom.linear_interpolate(newZoom * delta, Smooth)
	position.y += 3.7
	
