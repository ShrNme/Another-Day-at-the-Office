extends Node2D

@onready var inputLabel = get_node("input")
var string = ""

@onready var emailSpr = get_node("Email")

var counting = false
var counter = 0.2

func _ready() -> void:
	inputLabel.text = string


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	inputLabel.text = string
	if counting:
		counter -= delta
		if counter <= 0:
			get_parent().task_in_progress = false
			self.queue_free()

func _on_s_btn_pressed() -> void:
	string = string + "s"

func _on_o_btn_pressed() -> void:
	string = string + "o"

func _on_r_btn_pressed() -> void:
	string = string + "r"

func _on_y_btn_pressed() -> void:
	string = string + "y"

func _on_reset_btn_pressed() -> void:
	string = ""

func _on_send_btn_pressed() -> void:
	if string == "sorry":
		emailSpr.frame = 2 
		counting = true
	else:
		emailSpr.frame = 1
