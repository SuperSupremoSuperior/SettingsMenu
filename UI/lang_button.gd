extends Button
class_name LangButton

var lang_code: String = "en"

func _pressed() -> void:
	TranslationServer.set_locale(lang_code)
