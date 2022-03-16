extends Area2D
var velocitat : int = 300
var direccio = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(0,0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	direccio = Vector2.ZERO
	
	if Input.is_action_pressed("mou dreta"):
		direccio[0] = 1
	if Input.is_action_pressed("mou esquerra"):
		direccio[0] = -1
	if Input.is_action_pressed("mou adalt"):
		direccio[1] = -1
	if Input.is_action_pressed("mou abaix"):
		direccio[1] = 1
	position += direccio.normalized() * velocitat * delta

func _on_Personatge_area_entered(area :Area2D):
	print(area.name)
	if area.is_in_group('Final'):
		modulate = Color(1,0,0)
	elif area.is_in_group('Inici'):
		modulate = Color(0,1,0)
	$Godot.rotation_degrees = 45
	
func _on_Personatge_area_exited(area):
	modulate = Color(1,1,1)
	$Godot.rotation_degrees = 0
