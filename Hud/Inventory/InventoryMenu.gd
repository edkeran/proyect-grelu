extends CanvasLayer

var optionSelectedPlayerInventory = null
var characterName = ""
var imageCharacter = null
var isShowItemsInventory = false
var soundItemInventory = true

func _process(delta):
	if(Input.is_action_just_pressed("ui_interact")):
		if(optionSelectedPlayerInventory == Constants.inverntoryOptionPlayer.INVENTORYITEMS):
			$PanelItemsInventory.show()
			var sound = AudioStreamPlayer.new()
			sound.stream = preload("res://Music/UI_SFX_Set/switch10.wav")
			sound.autoplay = true
			add_child(sound)
			isShowItemsInventory = true
			soundItemInventory = false
			$PanelItemsInventory/GridContainer/Slot1.grab_focus()
		elif(!isShowItemsInventory):
			$PanelItemsInventory.hide()

func _ready():
	$PanelItemsInventory.hide()
	$PanelContainer/ItemsButton.grab_focus()
	$PanelContainer/CharacterName.text = characterName

func _set_color_modulate(colorMod):
	$PanelContainer.modulate = colorMod
	$PanelItemsInventory.modulate = colorMod

func _set_character_name(name):
	self.characterName = name
	$PanelContainer/CharacterName.text = characterName

func _set_image_character(characterImageItem):
	if(characterImageItem != null):
		self.imageCharacter = characterImageItem
		var textureCharacterInv = ImageTexture.new()
		var imageCharacterInventory = Image.new()
		imageCharacterInventory.load(imageCharacter)
		textureCharacterInv.create_from_image(imageCharacterInventory)
		$PanelContainer/CanvasImageCharacter/ImageCharacter.texture = textureCharacterInv

func _on_ItemsButton_focus_entered():
	optionSelectedPlayerInventory = Constants.inverntoryOptionPlayer.INVENTORYITEMS
	
func hide_items_array_list():
	$PanelItemsInventory.hide()

func entered_item_cell_song_focus():
	if(soundItemInventory):
		var sound = AudioStreamPlayer.new()
		sound.stream = preload("res://Music/UI_SFX_Set/switch11.wav")
		sound.autoplay = true
		sound.connect("finished", sound, "queue_free")
		add_child(sound)
	else:
		soundItemInventory = true
