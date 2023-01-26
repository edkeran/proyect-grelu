extends Node

var color_black = Color.black
var is_change_scence = false
var timerStarted = false

func _ready():
	#For this scene and only this one change the ui_left
	instance_joypad()
	$StartGame.grab_focus()

func _process(delta):
	if(is_change_scence):
		modulate_canvas(delta)
	if(is_change_scence and (int($CanvasModulate.color.r) <= int(0))):
		$CanvasModulate.color = Color.black
		if(!timerStarted):
			$TimerEsceneChange.start(1.5)
			timerStarted = true

func _on_StartGame_pressed():
	#Carga Una Animacion Para Luego recibir la señal para cambiar de escena
	$Camara.isZooming = true
	var start_song = AudioStreamPlayer.new()
	start_song.stream = preload("res://Music/GUI_Sound_Effects_by_Lokif/load.wav")
	start_song.autoplay = true
	self.add_child(start_song)

func _on_Camara_animation_completed():
	#Se implementa un modulate y realiza el cambio de escena
	is_change_scence = true

func modulate_canvas(delta):
	$CanvasModulate.color = $CanvasModulate.color.linear_interpolate(color_black * delta,0.4)

func instance_joypad():
	Input.connect("joy_connection_changed",self,"joy_con_changed")
	if(Input.get_connected_joypads().size() > 0):
		var defaultDevice = Input.get_connected_joypads().front()
		var eventJoypadDown = InputEventJoypadMotion.new()
		eventJoypadDown.device = defaultDevice
		eventJoypadDown.axis = JOY_AXIS_1
		eventJoypadDown.axis_value = 0.3
		var eventJoypadUp = InputEventJoypadMotion.new()
		eventJoypadUp.device = defaultDevice
		eventJoypadUp.axis = JOY_AXIS_1
		eventJoypadUp.axis_value = -0.3
		var eventJoypadLeft = InputEventJoypadMotion.new()
		eventJoypadLeft.device = defaultDevice
		eventJoypadLeft.axis = JOY_AXIS_0
		eventJoypadLeft.axis_value = -0.3
		var eventJoypadRight = InputEventJoypadMotion.new()
		eventJoypadRight.device = defaultDevice
		eventJoypadRight.axis = JOY_AXIS_0
		eventJoypadRight.axis_value = 0.3
		InputMap.action_add_event("ui_down", eventJoypadDown)
		InputMap.action_add_event("ui_up", eventJoypadUp)
		InputMap.action_add_event("ui_left", eventJoypadLeft)
		InputMap.action_add_event("ui_right", eventJoypadRight)

#Close The Game
func _on_ExitGame_pressed():
	var exit_song = AudioStreamPlayer.new()
	exit_song.stream = preload("res://Music/GUI_Sound_Effects_by_Lokif/misc_menu_2.wav")
	exit_song.autoplay = true
	self.add_child(exit_song)
	yield(get_tree().create_timer(1.3), "timeout")
	get_tree().quit()

#Changes The Scene To A New Game
func _on_TimerEsceneChange_timeout():
	get_tree().change_scene("res://ScenesGame/Houses/StartHouse.tscn")

