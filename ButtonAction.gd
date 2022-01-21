extends Area2D

signal btnPressed

func _ready():
	$ButtonIdle.show()
	$ButtonPressed.hide()
	
func _on_Button_area_entered(area):
	if(area.get_name() == "FeetArea"):
		$ButtonPressed.show()
		$ButtonIdle.hide()
		emit_signal("btnPressed")
