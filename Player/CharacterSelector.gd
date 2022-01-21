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
				emit_signal("changeCharacter")

func _on_Up_focus_entered():
	$Container/Up.modulate = modulateEnabled
	currentModulatePlayer = "Player"

func _on_Left_focus_entered():
	$Container/Left.modulate = modulateEnabled
	currentModulatePlayer = "Fawu"

func _on_Right_focus_entered():
	$Container/Right.modulate = modulateEnabled
	currentModulatePlayer = "Yiblin"

func _on_Up_focus_exited():
	$Container/Up.modulate = modulateDisabled
	
func _on_Left_focus_exited():
	$Container/Left.modulate = modulateDisabled

func _on_Right_focus_exited():
	$Container/Right.modulate = modulateDisabled
