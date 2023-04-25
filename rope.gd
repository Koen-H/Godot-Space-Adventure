@tool
extends Node2D
const ROPE_SEGMENT = preload("res://RopeSegment.tscn")

var nodeA
var nodeB

var rope_segments : int = 4 
var length
const ROPE_SEGMENT_LENGTH = 20
const ROPE_STRESS_LENGTH = 60
const ROPE_BULLET_STRESS_LENGTH = 50
var segments = []
var joints = []

var onBullet = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func create_rope_segments():
	break_rope()
	var prev_segment = $Ropeholder
#	print(nodeA.position)
	look_at(nodeB.global_transform.origin)
	length = Vector2(nodeA.global_transform.origin - nodeB.global_transform.origin).length()
	rope_segments = length/ROPE_SEGMENT_LENGTH
	print(length/ROPE_SEGMENT_LENGTH)
	rotation_degrees -= 90
	for i in range(rope_segments):
		var new_segment = ROPE_SEGMENT.instantiate()
		new_segment.position.y += ROPE_SEGMENT_LENGTH
		prev_segment.add_child(new_segment)
		var joint = PinJoint2D.new()
		prev_segment.add_child(joint)
		joint.position = prev_segment.position
		joint.node_a = prev_segment.get_path()
		joint.node_b = new_segment.get_path()
		prev_segment = new_segment
		prev_segment.full_rope = self
		segments.append(new_segment)
		joints.append(joint)
	
	var joint = PinJoint2D.new()
	prev_segment.add_child(joint)
	joint.position = prev_segment.position
	joint.node_a = prev_segment.get_path()
	joint.node_b = nodeB.get_path()
	joints.append(joint)
	if(length < ROPE_SEGMENT_LENGTH):
		queue_free()

func set_node_A(node : Node ) :
	nodeA = node
	var parent = get_parent()
	if(parent != null):
		parent.remove_child(self)
	nodeA.add_child(self)
	print(parent)
	global_position = nodeA.global_position
	if(range(joints.size()).has(0)):
#		joints[0].node_a = nodeA.get_path()
		print("test")
	pass
func set_node_B(node : Node ) :
	nodeB = node
	pass

func break_rope():
	for segment in segments:
		segment.queue_free()
	segments = []
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(nodeA == null || nodeB == null): return
	if(!onBullet && Vector2(nodeA.global_transform.origin - nodeB.global_transform.origin).length()>= length + ROPE_STRESS_LENGTH ||
		onBullet && Vector2(nodeA.global_transform.origin - nodeB.global_transform.origin).length()>= length + ROPE_BULLET_STRESS_LENGTH):
		break_rope()
		queue_free()
	pass
