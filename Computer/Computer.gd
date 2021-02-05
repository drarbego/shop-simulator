extends Spatial

var page_size = 10
var page_number = 0

var URL = "http://127.0.0.1:8000/"

var order_class = preload("res://Computer/Order.tscn")

onready var dialog = $OrdersPanel/MarginContainer/WindowDialog
onready var container = $OrdersPanel/MarginContainer/WindowDialog/ScrollContainer/VBoxContainer
onready var prev_button = $OrdersPanel/MarginContainer/WindowDialog/HBoxContainer/Prev


func _on_Area_body_entered(body):
	if not body is Character:
		return

	$OrdersPanel.set_visible(true)
	self.page_number = 0
	self.retrieve_orders()

func retrieve_orders():
	var paginated_url = URL + "?page_size=" + str(page_size) + "&page_number=" + str(page_number)
	var headers = ["Content-Type: application/json"]

	$RetrieveOrders.request(paginated_url, headers, true, HTTPClient.METHOD_GET)

func _on_Area_body_exited(body):
	if not body is Character:
		return

	dialog.set_visible(false)
	$OrdersPanel.set_visible(false)

func _on_RetrieveOrders_request_completed(result, response_code, headers, body):
	if result != $RetrieveOrders.RESULT_SUCCESS:
		return

	var response = parse_json(body.get_string_from_utf8())

	for child in self.container.get_children():
		child.queue_free()

	for order_data in response:
		var order = order_class.instance()
		order.init(
			order_data["values"]["memo"],
			order_data["values"]["tranid"],
			order_data["values"]["total"],
			order_data["values"]["trandate"]
		)
		self.container.add_child(order)

	self.prev_button.set_disabled(page_number == 0)
	$OrdersPanel/MarginContainer/WindowDialog/HBoxContainer/Page.set_text(str(page_number + 1))

	self.dialog.popup_centered()

func _on_Prev_pressed():
	self.page_number = clamp(self.page_number - 1, 0, INF)
	self.retrieve_orders()

func _on_Next_pressed():
	self.page_number = clamp(self.page_number + 1, 0, INF)
	self.retrieve_orders()
