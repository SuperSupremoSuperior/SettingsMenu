extends Control
class_name SettingsUI


signal settings_closed


const LANG_BUTTON = preload("uid://3mqg1cba02ni")

# Configs
@onready var hs_music: HSlider = %HS_music
@onready var hs_sfx: HSlider = %HS_sfx
@onready var ob_screen: OptionButton = %OB_screen
@onready var b_lang: Button = %B_lang

# Lang
@onready var lang_list: VBoxContainer = %Lang_list

func _ready() -> void:
	_load()
	list_langs()
	
	# Sliders
	hs_music.value_changed.connect(changed_music)
	hs_sfx.value_changed.connect(changed_sfx)
	
	# Options Buttons
	ob_screen.item_selected.connect(changed_screen)

func _load() -> void:
	# Sliders
	hs_music.value = SETTINGS.music_volume
	hs_sfx.value = SETTINGS.sfx_volume
	
	# Options Buttons
	for index in ob_screen.item_count:
		if SETTINGS.screen_type == ob_screen.get_item_text(index):
			ob_screen.select(index)
	
func _save() -> void:
	SETTINGS.save_configs()

func leave_settings() -> void:
	_save()
	settings_closed.emit()

# Sliders ------------------
func changed_music(new_value: float) -> void:
	SETTINGS.music_volume = new_value
	SETTINGS.update_audio()
func changed_sfx(new_value: float) -> void:
	SETTINGS.sfx_volume = new_value
	SETTINGS.update_audio()

# Options Buttons ----------
func changed_screen(new_index: int) -> void:
	SETTINGS.screen_type = ob_screen.get_item_text(new_index)
	SETTINGS.set_screen_type()
	
func list_langs() -> void:
	for lang_code in TranslationServer.get_loaded_locales():
		var new_button : LangButton = LANG_BUTTON.instantiate()
		
		new_button.text = TranslationServer.get_locale_name(lang_code)
		new_button.lang_code = lang_code
		
		lang_list.add_child(new_button)
