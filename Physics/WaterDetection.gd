extends Area2D

signal water_state_changed(is_in_water : bool)

var inWater : bool = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if(inWater == false):
#		var overlapping_bodies = get_overlapping_bodies()
		if(get_overlapping_bodies().size() >= 1):
			inWater = true
			emit_signal("water_state_changed", inWater)
	pass # Replace with function body.


func _on_body_exited(body):
	if(get_overlapping_bodies().size() == 0):
		inWater = false;
		emit_signal("water_state_changed", inWater)
	pass # Replace with function body.
