extends RigidBody2D

var full_rope
var mouse_in = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(mouse_in):
		if Input.is_action_just_pressed('Cut rope'):
			full_rope.queue_free()
	pass


func _input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed('Cut rope'):
			full_rope.queue_free()
