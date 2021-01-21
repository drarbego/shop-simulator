extends Control


func init(name, price, desc, image):
	$HBoxContainer/VBoxContainer/name.set_text(name)
	$HBoxContainer/VBoxContainer/desc.set_text(desc)
	$HBoxContainer/VBoxContainer/price.set_text(price)
	$HBoxContainer/TextureRect.set_texture(load(image))
