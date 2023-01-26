extends Node2D

signal player_object_entered(obj)
var callPlayerAddItem = false
export var inventoryItemImage = ""
export var worldItemImage = ""

func _ready():
	var imageTexture = ImageTexture.new()
	var image = Image.new()
	image.load("res://Assets/Items/consumables/" + worldItemImage)
	imageTexture.create_from_image(image)
	imageTexture.set_flags(Texture.FLAG_MIPMAPS)
	$SpriteConsumable.texture = imageTexture
	self.connect("player_object_entered",get_parent().get_node("Player"),"get_object_world")

func _process(delta):
	if(callPlayerAddItem and Input.is_action_pressed("ui_interact")):
		emit_signal("player_object_entered",self)

func _on_AreaConsumable_area_entered(area):
	callPlayerAddItem = true

func _on_AreaConsumable_area_exited(area):
	callPlayerAddItem = false
