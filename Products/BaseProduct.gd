extends Area

export var product_name := ""
export var description := ""
export var price := 0.0
export var image_name := ""
var image_path = ""


func _ready():
	image_path = "res://assets/" + image_name
	$Sprite3D.set_texture(load(image_path))

func _on_body_entered(body):
	if body is Character:
		body.add_product(
			product_name,
			description,
			price,
			image_path
		)
		self.queue_free()

func _v3_to_v2(v3):
	return Vector2(v3.x, v3.z)

func _get_v_to_character():
	var character_v3 = get_node("/root/World/Character").translation
	var character_v2 = self._v3_to_v2(character_v3)
	return (character_v2 - self._v3_to_v2(self.translation)).normalized()

func _process(_delta):
	var rot_delta = self._get_v_to_character()
	$Sprite3D.rotation_degrees.y = (rad2deg(rot_delta.angle()) - 90) * -1
	if Input.is_key_pressed(KEY_T):
		print(name, " V ", rot_delta, " rot ", $Sprite3D.rotation_degrees.y)
