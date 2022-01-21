extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	self.set_focus_mode(true)
	$ContainerText.visible = false
	$ContainerText.set_text("[center]Start Game[/center]")

func _on_StartGame_focus_entered():
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)
	$ContainerText.visible = true

func _on_StartGame_focus_exited():
	$ContainerText.visible = false
