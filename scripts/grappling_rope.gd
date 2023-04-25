extends Node2D

var direction := Vector2(0,0)
var tip := Vector2(0,0)

const SPEED = 50

var flying = false
var hooked = false

func shoot(dir: Vector2) -> void:
	direction = dir.normalized()
	flying = true
	tip = self.global_position
func release() -> void:
	flying = false
	hooked = false
	
func _process(delta: float) -> void:
	self.visible = flying or hooked
	if not self.visible:
		return
		var tip_loc = to_local(tip)
func _physics_process(delta: float) -> void:
	$Tip.global_position = tip
	if flying:
		if $Tip.move_and_collide(direction * SPEED):
			hooked = true
			flying = false
	tip = $Tip.global_position
