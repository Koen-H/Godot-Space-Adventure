@tool
extends RigidBody2D

var rope_length = 200
var segments = []
var lines = []

func create_rope_segment(z : int):
	var segment = RigidBody2D.new()
	var shape = CollisionShape2D.new()
	shape.shape = SegmentShape2D.new()
	shape.shape.set_a(Vector2(0, 0))
	shape.shape.set_b(Vector2(0, -rope_length))
	segment.add_child(shape)
	var line = Line2D.new()
	lines.append(line)
	add_child(line)
	return segment


func _ready():
	var previous_segment = self
	for i in range(10):
		var segment = create_rope_segment(i)
		segment.position = previous_segment.position - Vector2(0, rope_length)
		get_parent().add_child(segment)
		var joint = PinJoint2D.new()
		joint.node_a = previous_segment.get_path()
		joint.node_b = segment.get_path()
		previous_segment.add_child(joint)
		previous_segment = segment
		segments.append(segment)
