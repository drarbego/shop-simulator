extends Area


signal display_menu(show)

func _on_ActionableItem_body_entered(body):
	if body is Character:
		emit_signal("display_menu", true, body.context)

func _on_ActionableItem_body_exited(body):
	if body is Character:
		emit_signal("display_menu", false, {})
