extends Control


var product_class = preload("res://Interface/Product.tscn")

var order_data = {}
signal place_order(order_data)

func _ready():
	$InventoryContainer/WindowDialog.set_position($InventoryContainer.get_position())

func _delete_children(node):
	for child in node.get_children():
		node.remove_child(child)
		child.queue_free()

func _set_products(products, node):
	for data in products:
		var product = product_class.instance()
		product.init(data["name"], data["desc"], str(data["price"]), data["image"])
		node.add_child(product)

func _update_content(context):
	var container = $MarginContainer/WindowDialog/ScrollContainer/VBoxContainer

	self._delete_children(container)
	self._set_products(context["products"], container)

func _on_Inventory_pressed():
	var container = $InventoryContainer/WindowDialog/ScrollContainer/VBoxContainer
	self._delete_children(container)
	# Not the best way to do it, character related menus should be part of Character.tscn
	var products = get_node("/root/World/Character").context["products"]
	self._set_products(products, container)
	$InventoryContainer/WindowDialog.popup()

func display_menu(context):
	self.order_data = context
	self._update_content(context)
	$MarginContainer/WindowDialog.popup_centered()

func hide_menu():
	$MarginContainer/WindowDialog.hide()

func _on_Cancel_pressed():
	$MarginContainer/WindowDialog.set_visible(false)

func _on_Buy_pressed():
	emit_signal("place_order", order_data)
