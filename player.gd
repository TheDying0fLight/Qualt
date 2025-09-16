extends RigidBody3D

@onready var player_cam_arm: SpringArm3D = %PlayerCamArm

var max_speed := 1000

func _process(_delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept"):
        apply_impulse(Vector3(0, 1, 0) * 300)

    var input_dir := Input.get_vector("a", "d", "w", "s")
    var direction_xz := input_dir.rotated(-player_cam_arm.rotation.y)
    var direction := Vector3(direction_xz.x, 0, direction_xz.y)
    var forward_speed := (linear_velocity * direction).length()
    apply_force(direction * (max_speed - forward_speed))
