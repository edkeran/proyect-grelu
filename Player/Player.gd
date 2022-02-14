extends KinematicBody2D

signal interactItem
signal close_inventory
export var speed = 180
var inventoryComponent = null
var isGamepad = false
var defautlDevice
var velocity = Vector2()
var allowMovement = true
var activeSprite = null
var currentPlayerColor =  Color("#39A4D2")
var currentVoice = "Fawu.wav"
var currentCharacterName = "Fawu"
var isChangeCharacterLocked = false
var characterImagesNeutral = "res://Assets/Sprites/Playeable/Expresions/Fawu/NeutralGame.png"

func _ready():
	$CharacterSelector/Container.hide()
	activeSprite = $Sprite1Player
	configController()
	$CharacterSelector.connect("changeCharacter",self,"change_character")

func _physics_process(delta):
	if(allowMovement):
		walkPlayer(delta)
	else:
		stop_animation()
	control_character_selector()
	
	
func configController():
	Input.connect("joy_connection_changed",self,"joy_con_changed")
	isGamepad = Input.get_connected_joypads().size() > 0
	defautlDevice = Input.get_connected_joypads().front()

func walkPlayer(delta):
	velocity = Vector2()
	if(Input.is_action_just_pressed("ui_interact")):
		emit_signal("interactItem")
	if(Input.is_action_pressed("ui_run")):
		speed = 400
		activeSprite.frames.set_animation_speed("Right",6)
		activeSprite.frames.set_animation_speed("Left",6)
		activeSprite.frames.set_animation_speed("Back",6)
		activeSprite.frames.set_animation_speed("Front",6)
	else:
		speed = 180
	#Validate Diagonals
	if(validateDiagonals()):
		if(Input.is_action_pressed("ui_right") || axisDetectionPlayer("X")):
			velocity.x += 1
		if(Input.is_action_pressed("ui_left") || axisDetectionPlayer("-X")):
			velocity.x -= 1
		if(Input.is_action_pressed("ui_up") || axisDetectionPlayer("Y")):
			velocity.y -= 1
		if(Input.is_action_pressed("ui_down") || axisDetectionPlayer("-Y")):
			velocity.y += 1
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			activeSprite.play()
		else:
			activeSprite.stop()
	else:
		activeSprite.stop()
	
	move_and_collide(velocity * delta)
	if velocity.x != 0:
		activeSprite.animation = "Right" if velocity.x > 0 else "Left"
	elif velocity.y != 0:
		activeSprite.animation = "Back" if velocity.y < 0 else "Front"

func validateDiagonals():
	if(!(Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_up"))):
		if(!(Input.is_action_pressed("ui_left") and Input.is_action_pressed("ui_down"))):
			if(!(Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_up"))):
				if(!(Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_down"))):
					return true
	return false

func axisDetectionPlayer(direction):
	if(isGamepad && direction != null):
		if(direction == "X"):
			#Se valida que este sea el eje con valor maximo
			return Input.get_joy_axis(defautlDevice, JOY_AXIS_0) > 0.3 and abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_0)) > abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_1))
		if(direction == "-X"):
			return Input.get_joy_axis(defautlDevice, JOY_AXIS_0) < -0.3 and abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_0)) > abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_1))
		if(direction == "Y"):
			return Input.get_joy_axis(defautlDevice, JOY_AXIS_1) < -0.3 and abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_1)) > abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_0))
		if(direction == "-Y"):
			return Input.get_joy_axis(defautlDevice, JOY_AXIS_1) > 0.3 and abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_1)) > abs(Input.get_joy_axis(defautlDevice, JOY_AXIS_0))
	return false

func animateFawu():
	activeSprite = $Sprite1Player

func animateYiblin():
	activeSprite = $Sprite2Player

func stop_animation():
	activeSprite.stop()

func change_character():
	var currentPlayer = $CharacterSelector.currentModulatePlayer
	var entredInventory = false
	match currentPlayer:
		Constants.selectionsPlayer.PLAYER: 
			pass
		Constants.selectionsPlayer.FAWU:
			$Sprite1Player.show()
			$Sprite2Player.hide()
			currentPlayerColor =  Color("#39A4D2")
			activeSprite = $Sprite1Player
			currentVoice = "Fawu.wav"
			currentCharacterName = "Fawu"
		Constants.selectionsPlayer.YIBLIN:
			$Sprite1Player.hide()
			$Sprite2Player.show()
			activeSprite = $Sprite2Player
			currentPlayerColor =  Color("#EA1A1A")
			currentVoice = "Yiblin.wav"
			currentCharacterName = "Yiblin"
		Constants.selectionsPlayer.INVENTORY:
			entredInventory = true
			begin_inventory()
	$CharacterSelector/Container.hide()
	allowMovement = !entredInventory

func control_character_selector():
	if(Input.is_action_just_pressed("ui_change") 
		and !$CharacterSelector/Container.is_visible_in_tree()
		and !isChangeCharacterLocked):
		$CharacterSelector/Container.show()
		$CharacterSelector/Container/Left.grab_focus()
		allowMovement = false
	elif(Input.is_action_just_pressed("ui_change") and $CharacterSelector/Container.is_visible_in_tree()
		and !allowMovement):
		$CharacterSelector/Container.hide()
		allowMovement = true
		song_close_menu()
	elif(Input.is_action_just_pressed("ui_change") and isChangeCharacterLocked):
		end_inventory()

func begin_inventory():
	inventoryComponent = preload("res://Hud/Inventory/InventoryMenu.tscn").instance()
	inventoryComponent._set_color_modulate(currentPlayerColor)
	inventoryComponent._set_character_name(currentCharacterName)
	inventoryComponent._set_image_character(characterImagesNeutral)
	isChangeCharacterLocked = true
	self.add_child(inventoryComponent)

func end_inventory():
	if(inventoryComponent != null):
		inventoryComponent.queue_free()
		isChangeCharacterLocked = false
		$CharacterSelector/Container.hide()
		allowMovement = true
		song_close_menu()
		
func song_close_menu():
	var sound = AudioStreamPlayer.new()
	sound.stream = preload("res://Music/UI_SFX_Set/switch27.wav")
	sound.autoplay = true
	sound.connect("finished", sound, "queue_free")
	add_child(sound)
