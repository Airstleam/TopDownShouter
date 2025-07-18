extends Node2D

@onready var label = $Label
@onready var anim = $AnimationPlayer

func damage_text(damage):
	var format_text = "%0.1f"
	if damage == round(damage):
		format_text = "%0.0f"
	label.text = (format_text % damage)
	anim.play("damage_text")
