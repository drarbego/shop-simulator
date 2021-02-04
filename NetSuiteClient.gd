extends HTTPRequest

var URL = "http://127.0.0.1:8000/"

enum {
	CREATE,
	RETRIEVE
}
var last_action = null

signal orders_received(orders)

func _ready():
	self.connect("request_completed", self, "_on_request_completed")

func create_order(order_data):
	var headers = ["Content-Type: application/json"]

	var identifier = self._generate_identifier()
	order_data["identifier"] = identifier

	var body = to_json(order_data)

	print("creating order with id ... ", identifier)
	print("body ", body)
	self.last_action = CREATE
	request(URL, headers, true, HTTPClient.METHOD_POST, body)

func _generate_identifier():
	return "TEST_" + str(OS.get_unix_time())

func retrieve_orders(page_size, page_number):
	var headers = ["Content-Type: application/json"]
	var url = URL + "?page_size=" + str(page_size) + "&page_number=" + str(page_number)
	self.last_action = RETRIEVE
	request(URL, headers, true, HTTPClient.METHOD_GET)

func _on_request_completed(result, response_code, headers, body):
	if result != RESULT_SUCCESS:
		print("REQUEST FAILED with " + response_code)
		return
	
	print("body ", body.size())
	var response = parse_json(body.get_string_from_utf8())
	match last_action:
		RETRIEVE:
			emit_signal("orders_received", response)

