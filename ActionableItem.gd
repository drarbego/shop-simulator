extends Area


func _on_ActionableItem_body_entered(body):
	body.action = funcref(self, "execute_action")

func _on_ActionableItem_body_exited(body):
	body.action = null

func execute_action():
	$NetSuiteClient.create_order()
	print("action executed")
