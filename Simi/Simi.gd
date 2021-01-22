extends Spatial

export var dancing := false


func _ready():
	if dancing:
		var twerk = $AnimationPlayer.get_animation("Twerk")
		twerk.set_loop(true)
		$AnimationPlayer.play("Twerk")
