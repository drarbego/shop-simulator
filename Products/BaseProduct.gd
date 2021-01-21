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
