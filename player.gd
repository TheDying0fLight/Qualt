extends RigidBody3D

@onready var player_cam_arm: SpringArm3D = %PlayerCamArm

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        apply_impulse(Vector3(0, 1, 0) * 300)

    var input_dir := Input.get_vector("a", "d", "w", "s")
    var direction := (player_cam_arm.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    apply_force(direction * 100)
