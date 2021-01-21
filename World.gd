extends Spatial


func _on_Character_product_added():
	if $HUD/InventoryContainer/WindowDialog.visible:
		$HUD._on_Inventory_pressed()

func _on_ActionableItem_display_menu(show, context):
	if show:
		$HUD.display_menu(context)
	else:
		$HUD.hide_menu()
