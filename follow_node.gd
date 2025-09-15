extends SpringArm3D

@export var target: Node

func _process(_delta: float) -> void:
    position = target.position
