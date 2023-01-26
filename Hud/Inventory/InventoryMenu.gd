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
			load_items_grid(true)
		elif(!isShowItemsInventory):
			$PanelItemsInventory.hide()

func _ready():
	load_items_grid(false)
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

func load_items_player(itemsMap):
	var counter = 1
	itemsMap = itemsMap as Dictionary
	for itmMap in itemsMap.values():
		var slot = get_node("PanelItemsInventory/GridContainer/Slot" + str(counter)).get_node("CanvasLayer").get_node("ImageSlot") as TextureRect
		var imageTexture = ImageTexture.new()
		var image = Image.new()
		image.load("res://Assets/Items/consumables/" + itmMap.image)
		imageTexture.create_from_image(image)
		imageTexture.set_flags(Texture.FLAG_MIPMAPS)
		slot.texture = imageTexture
		counter+=1

func entered_item_cell_song_focus():
	if(soundItemInventory):
		var sound = AudioStreamPlayer.new()
		sound.stream = preload("res://Music/UI_SFX_Set/switch11.wav")
		sound.autoplay = true
		sound.connect("finished", sound, "queue_free")
		add_child(sound)
	else:
		soundItemInventory = true

func load_items_grid(showItem):
	for i in range(1,9):
		if(showItem):
			$PanelItemsInventory/GridContainer.get_node("Slot"+str(i)+"/CanvasLayer/ImageSlot").show()
		else:
			$PanelItemsInventory/GridContainer.get_node("Slot"+str(i)+"/CanvasLayer/ImageSlot").hide()
