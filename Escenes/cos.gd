extends KinematicBody2D

var velocitat_base = 200
var velocitat = Vector2.ZERO
var gravetat = Vector2.DOWN * 980
var a_escala = false
var salt = Vector2.UP * 400
var doblejump = 1
var velocitat_base_escala = 200

func _physics_process(delta):
	velocitat.x = 0
	print(gravetat)
	if Input.is_action_pressed("mou dreta"):
		velocitat += Vector2.RIGHT * velocitat_base
	if Input.is_action_pressed("mou esquerra"):
		velocitat += Vector2.LEFT * velocitat_base
	if is_on_floor():
		doblejump = 2
	if a_escala == false:
		if Input.is_action_just_pressed("mou adalt") and doblejump > 0:
			doblejump -= 1
			velocitat.y = 0
			velocitat += salt
	if a_escala == true:
		gravetat = Vector2.ZERO
		if Input.is_action_pressed("mou adalt"):
			velocitat = Vector2.UP * velocitat_base_escala
		elif Input.is_action_pressed("mou abaix"):
			velocitat = Vector2.DOWN * velocitat_base_escala
		else:
			velocitat.y = 0
	else:
		gravetat =  Vector2.DOWN * 980
	if position.y >= 1000:
		position = Vector2(39,525)
	anima(velocitat)
	velocitat += gravetat * delta
	velocitat = move_and_slide(velocitat,Vector2.UP)




func anima(velocitat: Vector2):
	var animacio : AnimatedSprite = $AnimatedSprite
	if a_escala == false:
		if velocitat.x > 0:
			animacio.flip_h = false
			animacio.play('Camina')
		elif velocitat.x < 0:
			animacio.flip_h = true
			animacio.play('Camina')
		if velocitat.x == 0 and velocitat.y == 0:
			animacio.play('Quiet')
	if a_escala == true:
		if velocitat.x > 0:
			animacio.flip_h = false
			animacio.play('Escala')
		elif velocitat.x < 0:
			animacio.flip_h = true
			animacio.play('Escala')
		if velocitat.y > 0:
			animacio.play('Escala')
		if velocitat.y < 0:
			animacio.play('Escala')
		if velocitat.x == 0 and velocitat.y == 0:
			animacio.play('Escala1')

func _on_Escala_body_entered(body):
	if body.name == 'Zombie':
		a_escala = true

func _on_Escala8_body_entered(body):
	if body.name == 'Zombie':
		a_escala = true
func _on_Escala8_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.name == 'Zombie':
		a_escala = false

func _on_Escala_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	if body.name == 'Zombie':
		a_escala = false
