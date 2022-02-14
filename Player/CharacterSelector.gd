extends CanvasLayer

const modulateDisabled = "#676767"
const modulateEnabled = "#ffffff"
var currentModulatePlayer = null

signal changeCharacter

func _ready():
	$Container/Up .modulate = modulateDisabled
	$Container/Left.modulate = modulateDisabled
	$Container/Right.modulate = modulateDisabled
	$Container/InventoryButton.modulate = modulateDisabled

func _process(delta):
	if($Container.is_visible_in_tree()):
		if(currentModulatePlayer != null && currentModulatePlayer != Constants.selectionsPlayer.PLAYER):
			if(Input.is_action_pressed("ui_interact") || Input.is_action_just_pressed("ui_run")):
				var sound = AudioStreamPlayer.new()
				sound.stream = preload("res://Music/UI_SFX_Set/switch15.wav")
				sound.autoplay = true
				add_child(sound)
				emit_signal("changeCharacter")

func _on_Up_focus_entered():
	$Container/Up.modulate = modulateEnabled
	currentModulatePlayer = Constants.selectionsPlayer.PLAYER
	_start_audio_selected()

func _on_Left_focus_entered():
	$Container/Left.modulate = modulateEnabled
	currentModulatePlayer = Constants.selectionsPlayer.FAWU
	_start_audio_selected()

func _on_Right_focus_entered():
	$Container/Right.modulate = modulateEnabled
	currentModulatePlayer = Constants.selectionsPlayer.YIBLIN
	_start_audio_selected()

func _on_InventoryButton_focus_entered():
	$Container/InventoryButton.modulate = modulateEnabled
	currentModulatePlayer = Constants.selectionsPlayer.INVENTORY
	_start_audio_selected()

func _on_Up_focus_exited():
	$Container/Up.modulate = modulateDisabled
	
func _on_Left_focus_exited():
	$Container/Left.modulate = modulateDisabled

func _on_Right_focus_exited():
	$Container/Right.modulate = modulateDisabled

func _on_InventoryButton_focus_exited():
	$Container/InventoryButton.modulate = modulateDisabled

func _start_audio_selected():
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch5.wav")
	sound.connect("finished", sound, "queue_free")
	sound.autoplay = true
	add_child(sound)
