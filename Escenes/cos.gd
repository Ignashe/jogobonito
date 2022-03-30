extends KinematicBody2D

var velocitat_base = 200
var velocitat_base_escala = 200
var velocitat = Vector2.ZERO
var gravetat = Vector2.DOWN * 980
var salt = Vector2.UP * 400
var doblejump = 1
var escala = false
var velocitat_escala = Vector2.ZERO

func _physics_process(delta):
	velocitat.x = 0
	if escala == false:
		if Input.is_action_pressed("mou dreta"):
			velocitat += Vector2.RIGHT * velocitat_base
		if Input.is_action_pressed("mou esquerra"):
			velocitat += Vector2.LEFT * velocitat_base
		if Input.is_action_just_pressed("mou adalt"):
			if doblejump  == 1:
				velocitat += Vector2.UP * 400
				doblejump -= 1
				velocitat.y = 0
				velocitat += salt
		if is_on_floor():
			doblejump = 1
		if position.y >= 1000:
			position = Vector2(45,394)
		velocitat += gravetat * delta
		anima(velocitat)
	if escala == true:
		if Input.is_action_just_pressed("mou adalt"):
			velocitat_escala += Vector2.UP * velocitat_base_escala
		if Input.is_action_pressed("mou dreta"):
			velocitat += Vector2.RIGHT * velocitat_base
		if Input.is_action_pressed("mou esquerra"):
			velocitat += Vector2.LEFT * velocitat_base
		velocitat_escala = move_and_slide(velocitat_escala,Vector2.UP)
		anima(velocitat_escala)
	velocitat = move_and_slide(velocitat, Vector2.UP)
func anima(velocitat: Vector2):
	var animacio : AnimatedSprite = $AnimatedSprite
	if velocitat.x > 0:
		animacio.flip_h = false
		animacio.play('Camina')
	elif velocitat.x < 0:
		animacio.flip_h = true
		animacio.play('Camina')
	if velocitat.y < -100:
		animacio.play('Salta')
		return
	if velocitat.y > 500:
		animacio.play('Cau')
		return
	if abs(velocitat.x) < 0.1:
		animacio.play('Quiet')



func _on_Escala_body_entered(body):
	escala = true
	print('a')


func _on_Escala_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	escala = false
	print('b')
