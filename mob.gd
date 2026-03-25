extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tipos_de_mobs = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = tipos_de_mobs.pick_random()
	$AnimatedSprite2D.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
