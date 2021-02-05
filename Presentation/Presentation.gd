extends Control

var slide = 1
var SLIDES_SIZE = 3


func _on_Next_pressed():
	slide = clamp(slide + 1, 1, SLIDES_SIZE)
	$Demo.set_visible(slide == SLIDES_SIZE)
	load_slide()

func _on_Back_pressed():
	slide = clamp(slide - 1, 1, SLIDES_SIZE)
	$Demo.set_visible(slide == SLIDES_SIZE)
	load_slide()

func _on_Demo_pressed():
	get_tree().change_scene("res://World.tscn")

func load_slide():
	var image_path = "res://Presentation/Slides/slide_" + str(slide) + ".png"
	$TextureRect.set_texture(load(image_path))
