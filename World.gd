extends Spatial


func _on_HUD_place_order(order_data):
	$NetSuiteClient.create_order(order_data)

func _on_Character_product_added():
	if $HUD/InventoryContainer/WindowDialog.visible:
		$HUD._on_Inventory_pressed()

func _on_ActionableItem_display_menu(show, context):
	if show:
		$HUD.display_menu(context)
	else:
		$HUD.hide_menu()

func _unhandled_input(event):
	if event.is_action_released("restart"):
		get_tree().reload_current_scene()
	if event.is_action_released("test"):
		$NetSuiteClient.retrieve_orders(10, 0)

func _on_NetSuiteClient_orders_received(orders):
	pass
