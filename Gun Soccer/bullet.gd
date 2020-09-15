extends RigidBody2D



func _on_RigidBody2D_body_entered(body):
	if !body.is_in_group('player') or !body.is_in_group('bullet'):
		queue_free()
