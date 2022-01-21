extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	$ContainerText.set_text("[center]Load Game[/center]")
	$ContainerText.visible = false


func _on_LoadGame_focus_entered():
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)
	$ContainerText.visible = true


func _on_LoadGame_focus_exited():
	$ContainerText.visible = false
