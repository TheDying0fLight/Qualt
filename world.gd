extends Node3D

@onready var player: RigidBody3D = %Player
@onready var grid: MeshInstance3D = %Grid

func _process(_delta: float) -> void:
    var target_pos := player.global_position
    grid.mesh.material.set_shader_parameter("centerOffset", Vector3(target_pos.x,0,target_pos.z))
