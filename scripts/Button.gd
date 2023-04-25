extends Area2D

var isActive: bool = false
@export var object : Node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func toggle_button(toggle : bool):
	print(toggle)
	isActive = toggle;
	if(isActive):
		$"Button Off".hide()
		$"Button On".show()
		object.do_something()
	else:
		$"Button Off".show()
		$"Button On".hide()
		object.stop_doing_something()
	
	pass


func _on_body_entered(body):
	toggle_button(true)
	pass # Replace with function body.



func _on_body_exited(body):
	toggle_button(false)
	pass # Replace with function body.
