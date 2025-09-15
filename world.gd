extends Node3D

@onready var static_camera: Camera3D = %StaticCamera
@onready var player_camera: Camera3D = %PlayerCamera
@onready var grid: MeshInstance3D = %Grid

var active_camera: Camera3D:
    set(camera):
        camera.make_current()
        grid.call_deferred("reparent", camera, false)
        active_camera = camera
        if fov: camera.fov = fov
        
var fov: float:
    set(new):
        fov = min(max(new, 1), 165)
        active_camera.fov = fov

func _ready() -> void:
    active_camera = static_camera
    fov = active_camera.fov

func _input(event: InputEvent) -> void:
    if Input.is_action_pressed("ctrl"):
        if event.is_action_pressed("1"):
            active_camera = player_camera
        if event.is_action_pressed("2"):
            active_camera = static_camera
    if event.is_action("scroll_up"): fov -= 1
    if event.is_action("scroll_down"): fov += 1
    if event is InputEventMouseMotion and event.relative.length() < 200:
        var cam_parent := active_camera.get_parent()
        if not cam_parent is SpringArm3D: return
        cam_parent.rotation.y += event.relative.x * -0.01
        cam_parent.rotation.x = min(max(cam_parent.rotation.x + event.relative.y * -0.01, deg_to_rad(-90)), deg_to_rad(90))


func _process(delta: float) -> void:
    var cam_parent := active_camera.get_parent()
    if not cam_parent is SpringArm3D: return
    cam_parent.global_rotation = cam_parent.rotation
