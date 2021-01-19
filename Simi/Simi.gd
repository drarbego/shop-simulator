extends Spatial


func _ready():
	var twerk = $AnimationPlayer.get_animation("Twerk")
	twerk.set_loop(true)
	$AnimationPlayer.play("Twerk")
