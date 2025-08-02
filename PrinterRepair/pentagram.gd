extends Area2D

var counter = 0.25
var counting = false
var rabbit_inside = true
@onready var rabbit = get_parent().get_node("Rabbit")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting:
		counter -= delta
	if counter <= 0.0:
		get_parent().get_parent().task_in_progress = false
		get_parent().queue_free()
	if rabbit_inside and rabbit.dead and !counting:
		get_parent().get_node("Printer").texture = load("res://PrinterRepair/printer_fixed.png")
		counting = true

func _on_area_entered(area: Area2D) -> void:
	if area.name == "Rabbit":
		rabbit_inside = true
	#	if area.dead and !counting:
	#		get_parent().get_node("Printer").texture = load("res://PrinterRepair/printer_fixed.png")
	#		counting = true


func _on_area_exited(area: Area2D) -> void:
	if area.name == "Rabbit":
		rabbit_inside = false
