extends RigidBody2D
class_name Bullet

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var velocityBullet = Vector2(0,1)
var attached_rope = null

var player: Player;

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	rotation_degrees -= 90

func _physics_process(delta):
	var collision_info = move_and_collide(velocityBullet.normalized() * delta * SPEED)
	if (collision_info):
		if(collision_info.get_collider().is_in_group("rope-attacheable")):
			if(attached_rope != null):
				attached_rope.set_node_A(collision_info.get_collider())
				attached_rope.create_rope_segments()
				attached_rope.onBullet= false
			else:
			#player.attach_grapling(collision_info.get_collider())
				player.attach_rope(collision_info.get_collider())
		queue_free()

func TEST():
	print("TEST");
