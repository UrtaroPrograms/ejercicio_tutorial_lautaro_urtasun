extends Node
@export var escena_mob : PackedScene
var puntos

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	puntos = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(puntos)
	$HUD.show_message("Get Ready")

func _on_mob_timer_timeout():
	var mob = escena_mob.instantiate()
	
	var mob_ubicacion_spawn = $MobPath/MobSpawnLocation
	mob_ubicacion_spawn.progress_ratio = randf()
	
	mob.position = mob_ubicacion_spawn.position
	
	var direccion = mob_ubicacion_spawn.rotation + PI/2
	
	direccion += randf_range(-PI/4, PI/4)
	mob.rotation = direccion
	
	var velocidad = Vector2(randf_range(150.0,250.0), 0.0)
	mob.linear_velocity = velocidad.rotated(direccion)
	
	add_child(mob)

func _on_score_timer_timeout():
	puntos += 1
	$HUD.update_score(puntos)

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
