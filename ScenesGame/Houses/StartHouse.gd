extends Node

var presentaMensaje = false
var cajaDeTexto

func _ready():
	if($CanvasModulate.visible):
		$Player/Light2D.visible = true

func _on_Player_interactItem():
	if(presentaMensaje):
		cajaDeTexto = preload("res://Hud/TextBoxDialog/dialogHud.tscn").instance()
		cajaDeTexto.currentLabelInfo=["Es una chimenea, mejor me muevo esta muy [tornado radius=6 freq=3]caliente[/tornado]."]
		cajaDeTexto.currentCharacterColorTextBox = $Player.currentPlayerColor
		cajaDeTexto.change_text_color(Color(255,255,255))
		cajaDeTexto.connect("text_completed", self, "_on_dialog_ended")
		cajaDeTexto.get_node("TextureRect/AudioStreamPlayer").stream = load("res://Music/FX_Character_Talking/" + $Player.currentVoice)
		get_tree().get_root().add_child(cajaDeTexto)
		$Player.allowMovement = false

func _on_EventChimneyDlg_area_entered(area):
	presentaMensaje = true

func _on_EventChimneyDlg_area_exited(area):
	presentaMensaje = false

func _on_dialog_ended():
	$Player.allowMovement = true

func _on_EventRoomChimne_body_exited(body):
	$Player.z_index = 0
		
func _on_EventRoomChimne_area_entered(area):
	$Player.z_index = 5
