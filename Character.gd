extends KinematicBody


const SPEED = 5

var velocity = Vector3.ZERO
var rot_speed = 0.85

var action := FuncRef.new()

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

	if event.is_action_released("ui_accept"):
		if action and action.is_valid():
			action.call_func()

func get_input(delta):
	var vy = velocity.y
	velocity = Vector3.ZERO
	if Input.is_action_pressed("ui_up"):
		velocity += -transform.basis.z * SPEED
	if Input.is_action_pressed("ui_down"):
		velocity += transform.basis.z * SPEED
	if Input.is_action_pressed("ui_right"):
		rotate_y(-rot_speed * delta)
	if Input.is_action_pressed("ui_left"):
		rotate_y(rot_speed * delta)
	velocity.y = vy

func _physics_process(delta):
	get_input(delta)
	velocity = move_and_slide(velocity, Vector3.UP)


func _on_ActionableItem_body_entered(body):
	pass # Replace with function body.
