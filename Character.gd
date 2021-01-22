extends KinematicBody

class_name Character

const SPEED = 5

var velocity = Vector3.ZERO
var rot_speed = 1.85
var current_camera = 0

var context = {
	"lines": [],
	"payment_data": {
		"custom_fields": {
			"cost_period_id": "XYZ",
		},
	},
	"shipping_address": {
		"wh_region": "houston_warehouse",
		"phone": "33322164",
	},
	"currency": "USD",
	"ext": "Ensign Energy",
	"afe_number": "1234",
	"po_number": "Po - 33",
	"created_on": "12/25/2020",
	"requestor": null,
	"customer_comment": "some comment",
}

signal product_added

func _ready():
	var anim = $Shrek/AnimationPlayer.get_animation("Run")
	anim.set_loop(true)
	$Shrek/AnimationPlayer.set_current_animation("Run")
	$Shrek/AnimationPlayer.stop()

func _unhandled_input(event):
	if event.is_action_pressed("ui_up"):
		$Shrek/AnimationPlayer.play()

	if event.is_action_released("ui_up"):
		$Shrek/AnimationPlayer.stop(false)

	if event.is_action_pressed("ui_down"):
		$Shrek/AnimationPlayer.play_backwards()

	if event.is_action_released("ui_down"):
		$Shrek/AnimationPlayer.stop(false)

	if event.is_action_pressed("change_camera"):
		var cameras = $Cameras.get_children()
		self.current_camera = (self.current_camera + 1) % len(cameras)
		cameras[self.current_camera].set_current(true)

func get_input(delta):
	# TODO use vector2 for movement
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += -transform.basis.z * SPEED
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.z * SPEED
	if Input.is_action_pressed("ui_right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("ui_left"):
		rotate_y(rot_speed * delta)

	if self.global_transform.origin.y > 0.1:
		velocity.y = -0.1
	if self.global_transform.origin.y < -0.1:
		velocity.y = 0.1

func add_product(sku, desc, price, image_path):
	self.context["lines"].append({
		"sku": sku,
		"qty": "1.000000000",
		"desc": desc,
		"price": price,
		"amount": price,
		"image": image_path,
		"taxable": false
	})
	emit_signal("product_added")
	$AuraDust.emitting = true
	$AuraGround.emitting = true

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP, true, 1)
