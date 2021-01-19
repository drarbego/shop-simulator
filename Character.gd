extends KinematicBody

class_name Character

const SPEED = 5

var velocity = Vector3.ZERO
var rot_speed = 1.85

var context = {
	"products": [
		{
			"name": "pump",
			"desc": "algo",
			"price": "$120.00",
		},
		{
			"name": "pump 2",
			"desc": "otra cosa",
			"price": "$300.00",
		}
	]
}

func _ready():
	var anim = $Shrek/AnimationPlayer.get_animation("ArmaturemixamocomLayer0")
	anim.set_loop(true)
	$Shrek/AnimationPlayer.set_current_animation("ArmaturemixamocomLayer0")
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

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP, true, 1)
