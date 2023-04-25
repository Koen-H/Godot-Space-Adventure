extends DampedSpringJoint2D
class_name BetterRope

var nodeA : Node
var nodeB : Node
var line
var rope_length : float

func set_node_A(node : Node ) :
	nodeA = node;
	self.node_a = node.get_path()
	if(get_parent() != null):
		
		self.get_parent().remove_child(self)
	node.add_child(self)
#	print(node.name)
	#self.get_parent().remove_child(self)
#	print(self.get_parent().name)
#	self.position = node.position
	pass

func set_node_B(node : Node ) :
	nodeB = node
	line = $Line2D
	remove_child(line)
	self.get_parent().get_parent().add_child(line)
	
#	var direction = node.global_transform.origin - global_transform.origin
#	print(direction)
#	look_at(direction - global_transform.origin)
	self.node_b = node.get_path()
	self.look_at(node.global_transform.origin)
	self.rotation_degrees -= 90
	self.length = Vector2(nodeA.global_transform.origin - nodeB.global_transform.origin).length()
	rope_length = self.length
	
	pass

func set_rope():
	self.look_at(nodeB.global_transform.origin)
	self.rotation_degrees -= 90

	
func _process(delta):
#	print(self.length)
	if(line != null):
		self.length = rope_length
		line.points = []
		line.add_point(nodeA.global_transform.origin)
		line.add_point(nodeB.global_transform.origin)
