extends Node2D
class_name GravitationalSphere

# Called when the node enters the scene tree for the first time.
func _ready():
	if(!is_active_on_start):
		$"Gravitational Area".hide()
		$"Gravitational Area/CollisionShape2D".set_deferred("disabled", true)
	pass # Replace with function body.

@export var is_active_on_start : bool
var colliding_bodies = []

func _on_gravitational_area_body_exited(body):
	if(body is Player):
		if(body.gravSphere == self):
			body.gravSphere = null
#	if body in colliding_bodies:
#		colliding_bodies.erase(colliding_bodies.find(body))
	pass # Replace with function body.
	
func _process(delta):
	on_body_stay()

func on_body_stay():
#	for body in colliding_bodies:
#		if(body is Player):
#			var body_transform = body.get_global_transform()  # Get the global transform of the body that entered
#			var this_transform = get_global_transform()  # Get the global transform of this object
#
#			var entered_center = this_transform.origin  # Get the world space position of this object
#			var body_pos = body_transform.origin  # Get the world space position of the body that entered
#
#			var direction = (entered_center - body_pos).normalized()  # Get the direction vector from the body towards the center of the entered object
#			var rot = Vector2.UP.angle_to(-direction)
#			body.rotation = rot
#		pass
	pass

func _on_gravitational_area_body_entered(body):
	if(body is Player):
		body.gravSphere = self
#	colliding_bodies.append(body)
	pass # Replace with function body.

func get_grav_rotation(body):
	var body_transform = body.get_global_transform()  # Get the global transform of the body that entered
	var this_transform = get_global_transform()  # Get the global transform of this object

	var entered_center = this_transform.origin  # Get the world space position of this object
	var body_pos = body_transform.origin  # Get the world space position of the body that entered

	var direction = (entered_center - body_pos).normalized()  # Get the direction vector from the body towards the center of the entered object
	var rot = Vector2.UP.angle_to(-direction)
	return rot

func do_something():
	print("I DO SMETIGN")
	$"Gravitational Area/CollisionShape2D".set_deferred("disabled", false)
	$"Gravitational Area".show()
	
func stop_doing_something():
	$"Gravitational Area/CollisionShape2D".set_deferred("disabled", true)
	$"Gravitational Area".hide()
