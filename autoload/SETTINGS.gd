extends Node
# SETTINGS.gd

# Audio
var sfx_volume: float = 0.5
var music_volume: float = 0.5
# Video
var screen_type: String = "Fullscreen"
# Misc
var lang_code: String = "en"

# FILE
const CONFIG_FILE: String = "user://settings.cfg"

func _ready() -> void:
	load_configs()
	set_screen_type()

func update_audio() -> void:
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Music"), music_volume)
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("SFX")  , sfx_volume)

func save_configs() -> void:
	var config : ConfigFile = ConfigFile.new()
	
	config.set_value("audio", "music",      music_volume)
	config.set_value("audio", "sound",      sfx_volume )
	config.set_value("video", "screen_type",screen_type)
	config.set_value("misc",  "lang",       lang_code)
	
	config.save(CONFIG_FILE)

func load_configs() -> void:
	var config : ConfigFile = ConfigFile.new()
	config.load(CONFIG_FILE)
	
	music_volume = config.get_value("audio","music",      0.5)
	sfx_volume   = config.get_value("audio","sound",      0.5)
	screen_type  = config.get_value("video","screen_type","Fullscreen")
	lang_code    = config.get_value("misc", "lang",       "en")
	
	# Apply Config
	update_audio()
	TranslationServer.set_locale(lang_code)

func set_screen_type() -> void:
	match screen_type:
		"Fullscreen":DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		"Windowed"  :DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		"Borderless":DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
