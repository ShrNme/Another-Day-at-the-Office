extends Node2D

@onready var paper = get_node("Paper")
@onready var paper2 = get_node("Paper2")
@onready var paper3 = get_node("Paper3")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if paper == null and paper2==null and paper3==null:
		get_parent().task_in_progress = false
		self.queue_free()
