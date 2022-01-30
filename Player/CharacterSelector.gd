extends CanvasLayer

const modulateDisabled = "#676767"
const modulateEnabled = "#ffffff"
var currentModulatePlayer = null

signal changeCharacter

func _ready():
	$Container/Up .modulate = modulateDisabled
	$Container/Left.modulate = modulateDisabled
	$Container/Right.modulate = modulateDisabled

func _process(delta):
	if($Container.is_visible_in_tree()):
		if(currentModulatePlayer != null && currentModulatePlayer != "Player"):
			if(Input.is_action_pressed("ui_interact")):
				var sound = AudioStreamPlayer.new()
				sound.stream = preload("res://Music/UI_SFX_Set/switch15.wav")
				sound.autoplay = true
				add_child(sound)
				emit_signal("changeCharacter")

func _on_Up_focus_entered():
	$Container/Up.modulate = modulateEnabled
	currentModulatePlayer = "Player"
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)

func _on_Left_focus_entered():
	$Container/Left.modulate = modulateEnabled
	currentModulatePlayer = "Fawu"
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)

func _on_Right_focus_entered():
	$Container/Right.modulate = modulateEnabled
	currentModulatePlayer = "Yiblin"
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.autoplay = true
	add_child(sound)

func _on_Up_focus_exited():
	$Container/Up.modulate = modulateDisabled
	
func _on_Left_focus_exited():
	$Container/Left.modulate = modulateDisabled

func _on_Right_focus_exited():
	$Container/Right.modulate = modulateDisabled
