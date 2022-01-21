extends CanvasLayer

var currentLabelInfo = []
var expresionCharacter
var currentIndexText = 0
var currentCharacterColorTextBox
var allowNextText = false
signal text_completed

func _ready():
	if(currentCharacterColorTextBox != null):
		$TextureRect.modulate = currentCharacterColorTextBox
	if(currentLabelInfo != null and currentLabelInfo.size() > 0):
		load_message() 

func _process(delta):
	if(Input.is_action_just_pressed("ui_interact") and allowNextText):
		load_message()
	
func load_message():
	if(currentIndexText < currentLabelInfo.size()):
		$TextureRect/CurrentText.bbcode_text=currentLabelInfo[currentIndexText]
		$TextureRect/CurrentText.percent_visible = 0
		tween_text_animation()
		currentIndexText+=1
	else:
		destroy_dialog()

func tween_text_animation():
	$TextureRect/Tween.interpolate_property(
		$TextureRect/CurrentText, "percent_visible", 0, 1, 1, 
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
	)
	$TextureRect/Tween.start()

func change_text_color(txtColor):
	$TextureRect/CurrentText.add_color_override("default_color", txtColor)

func _on_Tween_tween_completed(object, key):
	#$TextureRect/AudioStreamPlayer.stop()
	allowNextText = true

func destroy_dialog():
	emit_signal("text_completed")
	queue_free()

func _on_Tween_tween_step(object, key, elapsed, value):
	if(not $TextureRect/AudioStreamPlayer.playing):
		$TextureRect/AudioStreamPlayer.play()
	elif ($TextureRect/AudioStreamPlayer.get_playback_position() > 0.1):
		$TextureRect/AudioStreamPlayer.stop()
