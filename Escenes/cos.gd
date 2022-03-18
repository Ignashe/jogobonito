extends KinematicBody2D

var velocitat_base = 200
var velocitat = Vector2.ZERO
var gravetat = Vector2.DOWN * 980
var salt = Vector2.UP * 400
var doblejump = 1

func _physics_process(delta):
	velocitat.x = 0
	if Input.is_action_pressed("mou dreta"):
		velocitat += Vector2.RIGHT * velocitat_base
	if Input.is_action_pressed("mou esquerra"):
		velocitat += Vector2.LEFT * velocitat_base
	if is_on_floor():
		doblejump = 2
	if Input.is_action_just_pressed("mou adalt") and doblejump > 0:
		doblejump -= 1
		velocitat.y = 0
		velocitat += salt
	if position.y >= 1000:
		position = Vector2(59,304)
	velocitat += gravetat * delta
	velocitat = move_and_slide(velocitat, Vector2.UP)



