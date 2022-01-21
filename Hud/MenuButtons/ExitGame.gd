extends TextureButton

func _ready():
	$ContainerText.set_text("[center]Exit[/center]")
	$ContainerText.visible = false
	grab_focus()

func _on_ExitGame_focus_entered():
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)
	$ContainerText.visible = true


func _on_ExitGame_focus_exited():
	$ContainerText.visible = false
