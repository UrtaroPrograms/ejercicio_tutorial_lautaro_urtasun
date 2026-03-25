extends Area2D
signal golpeado
@export var velocidad = 400 # Que tan rápido se mueve el jugador (en píxeles por segundo)
var tamaño_pantalla # El tamaño de la pantalla del juego


# Called when the node enters the scene tree for the first time.
func _ready():
	tamaño_pantalla = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var rapidez = Vector2.ZERO # El vector de movimiento del jugador
	if Input.is_action_pressed("move_right"):
		rapidez.x += 1
	if Input.is_action_pressed("move_left"):
		rapidez.x -= 1
	if Input.is_action_pressed("move_down"):
		rapidez.y += 1
	if Input.is_action_pressed("move_up"):
		rapidez.y -= 1
	
	if rapidez.length() > 0:
		rapidez = rapidez.normalized() * velocidad
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += rapidez * delta
	position = position.clamp(Vector2.ZERO, tamaño_pantalla)
	
	if rapidez.x != 0:
		$AnimatedSprite2D.animation = "caminar"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = rapidez.x < 0
	
	elif rapidez.y !=0:
		$AnimatedSprite2D.animation= "arriba"
		$AnimatedSprite2D.flip_v = rapidez.y > 0

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(body: Node2D):
	hide() #El jugador desaparece tras ser golpeado
	golpeado.emit()
	$CollisionShape2D.set_deferred("disabled",true)
