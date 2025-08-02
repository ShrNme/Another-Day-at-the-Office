extends Area2D

var mouse_x_offset = 0
var mouse_y_offset = 0
var mouseOver = false
var alreadyDragging = false

@onready var particle = preload("res://PaperShredding/shredParticle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("click") and mouseOver and !alreadyDragging:
		alreadyDragging = true
		mouse_x_offset = get_viewport().get_mouse_position().x - position.x
		mouse_y_offset = get_viewport().get_mouse_position().y - position.y
	elif Input.is_action_just_released("click"):
		alreadyDragging = false
	if alreadyDragging:
		position.x = get_viewport().get_mouse_position().x - mouse_x_offset
		position.y = get_viewport().get_mouse_position().y -mouse_y_offset

func _on_mouse_entered() -> void:
	mouseOver = true


func _on_mouse_exited() -> void:
	mouseOver = false


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Shredder":
		#get_parent().get_node("ShredParticle").emitting = true
		var temp = particle.instantiate()
		get_parent().get_node("ParticlePoint").add_child(temp)
		temp.emitting = true
		self.queue_free()
		#add a particle effect for this later
