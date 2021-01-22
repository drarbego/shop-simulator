extends HTTPRequest

var URL = "http://127.0.0.1:8000/"


func _ready():
	self.connect("request_completed", self, "_on_request_completed")

func create_order(order_data):
	var headers = ["Content-Type: application/json"]

	var identifier = self._generate_identifier()
	order_data["identifier"] = identifier

	var body = to_json(order_data)

	print("creating order with id ... ", identifier)
	print("body ", body)
	request(URL, headers, true, HTTPClient.METHOD_POST, body)

func _generate_identifier():
	return "TEST_" + str(OS.get_unix_time())

func _get_order_data():
	var identifier = "TEST_" + str(OS.get_unix_time())
	print("creating order with id ... ", identifier)

	return {
		"identifier": identifier,
		"payment_data": {
			"custom_fields": {
				"cost_period_id": "XYZ",
			},
		},
		"shipping_address": {
			"wh_region": "houston_warehouse",
			"phone": "33322164",
		},
		"lines": [{
			"sku": "X70-07373",
			"qty": "1.000000000",
			"rate": "342.49",
			"amount": "342.49",
			"taxable": false
		}, {
			"sku": "X91-00001",
			"qty": "1.000000000",
			"rate": "4.07",
			"amount": "4.07",
			"taxable": false
		}, {
			"sku": "X70-06199",
			"qty": "1.000000000",
			"rate": "6.74",
			"amount": "6.74",
			"taxable": false
		}, {
			"sku": "X91-02043",
			"qty": "1.000000000",
			"rate": "567.69",
			"amount": "567.69",
			"taxable": false
		}, {
			"sku": "X91-01810",
			"qty": "1.000000000",
			"rate": "9.98",
			"amount": "9.98",
			"taxable": false
		}, {
			"sku": "X70-08934",
			"qty": "1.000000000",
			"rate": "616.15",
			"amount": "616.15",
			"taxable": true
		}],
		"currency": "USD",
		"ext": "Ensign Energy",
		"afe_number": "1234",
		"po_number": "Po - 33",
		"created_on": "12/25/2020",
		"requestor": null,
		"customer_comment": "some comment",
	}

func _on_request_completed(result, response_code, headers, body):
	var response = parse_json(body.get_string_from_utf8())
	if result == RESULT_SUCCESS:
		print("Order created")
	else:
		print("request failed :(")
