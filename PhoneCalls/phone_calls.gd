extends Node2D


@onready var output = get_node("CallingNumber")
@onready var dialogue = get_node("Dialogue")
var string = ""
var calling = false
var calling_failed = false
var counter = 0.1
var wordIndex = 0
var done = false
var callFail = "Who is this? I think you have the wrong number."
var callString = "Hello, this is the time company, eating valuable moments of your life since the day you were born, how can we harm you?"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	callString = callString.split(" ") #ok maybe dynamic typing ain't that bad
	callFail = callFail.split(" ")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	output.text = string
	if calling:
		counter -= delta
		if counter <= 0:
			dialogue.text += callString[wordIndex] + " "
			wordIndex +=1
			counter = 0.1
		if wordIndex >= callString.size():
			calling = false
			done = true
	if calling_failed:
		counter -= delta
		if counter <= 0:
			dialogue.text += callFail[wordIndex] + " "
			wordIndex +=1
			counter = 0.1
		if wordIndex >= callFail.size():
			calling_failed = false
			wordIndex = 0
	if done:
		counter -= delta
		if counter <= 0:
			get_parent().task_in_progress = false
			self.queue_free()

func _on__pressed() -> void:
	string += "0"


func _on_call_pressed() -> void:
	if string == "18008463":
		calling = true
		dialogue.text = ""
	else:
		calling_failed = true
	
func _on_1_pressed() -> void:
	string += "1"

func _on_2_pressed() -> void:
	string += "2"

func _on_3_pressed() -> void:
	string += "3"

func _on_4_pressed() -> void:
	string += "4"
	
func _on_5_pressed() -> void:
	string += "5"
	
func _on_6_pressed() -> void:
	string += "6"

func _on_7_pressed() -> void:
	string += "7"

func _on_8_pressed() -> void:
	string += "8"

func _on_9_pressed() -> void:
	string += "9"

func _on_reset_pressed() -> void:
	string = ""
