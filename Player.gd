extends CharacterBody2D
class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -325.0
const SWIM_JUMP :float = -225.0
const SWIM_GRAVITY : float = 0.25
const SWIM_VELOCITY_CAP : float = 50
const BULLETPREFAB = preload("res://bullet.tscn")

const ROPE_PREFAB = preload("res://better_rope.tscn")
const REAL_ROPE_PREFAB = preload("res://rope.tscn")
var current_rope

var gravSphere : GravitationalSphere = null
var target_rotation : float
const ROTATION_SPEED : float = 7.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var is_in_water : bool = false

func _physics_process(delta):
	handle_rotation(delta)
	var gravityDir : Vector2 = Vector2.DOWN
	gravityDir = gravityDir.rotated(rotation)
	set_up_direction(-gravityDir)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += gravityDir * gravity * delta
	if(is_in_water):
#		velocity +=  clampf(velocity.rotated(-rotation).y + (gravity * delta * SWIM_GRAVITY),-10000, SWIM_VELOCITY_CAP)
		velocity = gravityDir * clampf(velocity.rotated(-rotation).y + (gravity * delta * SWIM_GRAVITY),-10000, SWIM_VELOCITY_CAP)

	# Handle Jump.
	if Input.is_action_just_pressed('Jump'):
		if(is_on_floor()):
			velocity = Vector2(0,JUMP_VELOCITY).rotated(rotation)
		if(is_in_water):
			velocity = Vector2(0,SWIM_JUMP).rotated(rotation)

#	# Get the input direction and handle the movement/deceleration.
#	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("Left", "Right")
	if direction:
		var localVel = velocity.rotated(-rotation)
		localVel.x = direction * SPEED
#		velocity = Vector2(direction * SPEED, localVel.y).rotated(rotation)
		if(localVel.x < 0):
			$AnimatedSprite2D.flip_h = false;
		elif(localVel.x>0):
			$AnimatedSprite2D.flip_h = true;
		velocity = localVel.rotated(rotation)
	else:
		var localVel = velocity.rotated(-rotation)
		localVel.x = move_toward(localVel.x, 0, SPEED)
		velocity = localVel.rotated(rotation)
	move_and_slide()
	if Input.is_action_just_pressed('shoot'):
		$Node2D.look_at(get_global_mouse_position())
		shoot()
	push()

func push():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(-collision.get_normal() * (SPEED/2))
	pass

func _on_water_detection_water_state_changed(is_in_water : bool):
	self.is_in_water = is_in_water
	pass # Replace with function body.



func attach_rope(node : Node):
	if(current_rope == null):
		current_rope = REAL_ROPE_PREFAB.instantiate()
		current_rope.set_node_A(self)
		current_rope.set_node_B(node)
	else:
		current_rope.set_node_A(node)
	current_rope.create_rope_segments()
	print("Rope attached")

func add_coins():
	$HUD.add_coins()

func win():
	$HUD.win()

#Old rope
#func attach_grapling(node : Node):
#	if(current_rope == null):
#		print("Attached grappling! once")
#		current_rope = ROPE_PREFAB.instantiate()
#		current_rope.set_node_A(self)
#		current_rope.set_node_B(node)
#		current_rope.set_rope()
#	else:
#		print("Attached grappling! twice")
#		current_rope.set_node_A(node)
#		current_rope.set_rope()
#		current_rope = null
#	pass
#

func handle_rotation(delta):
	if(gravSphere == null):
		target_rotation = 0
	else:
		target_rotation = gravSphere.get_grav_rotation(self)
	#rotation = target_rotation
	rotation = lerp_angle(rotation, target_rotation, delta * ROTATION_SPEED)

func shoot():
	var bullet = BULLETPREFAB.instantiate()
	bullet.player = self
	get_parent().add_child(bullet)
	bullet.position = $Node2D/Marker2D.global_position
	bullet.velocityBullet = get_global_mouse_position() - bullet.position
	if(current_rope != null):
		current_rope.set_node_A(bullet)
		current_rope.create_rope_segments()
		current_rope.onBullet = true
		bullet.attached_rope = current_rope
		current_rope = null
#	if(current_rope != null):
#		current_rope.set_node_A(bullet)
#		var bulletRope = REAL_ROPE_PREFAB.instantiate()
#		bulletRope.set_node_A(bullet)
#		bulletRope.set_node_B(current_rope.nodeB)
#		current_rope.break_rope()
