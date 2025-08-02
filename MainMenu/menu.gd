extends Node2D

var clickable = false
@onready var thing = get_node("Start_button/button_spr")
@onready var workplace = load("res://workplace.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("click") and clickable:
		add_sibling(workplace.instantiate())
		self.queue_free()


func _on_start_button_mouse_entered() -> void:
	clickable = true
	thing.frame = 1
	


func _on_start_button_mouse_exited() -> void:
	clickable = false
	thing.frame = 0
