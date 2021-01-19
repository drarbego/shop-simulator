extends Spatial


func _on_ActionableItem_display_menu(show, context):
	if show:
		$HUD.display_menu(context)
	else:
		$HUD.hide_menu()
