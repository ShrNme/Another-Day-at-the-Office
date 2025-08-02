extends Node2D

var fire_message
var message_array
var speaking = true
var fire_reason = 0 #set to 0 by default (fired for incomplete tasks, can be set to 1 if you're fired for not looking busy
var speak_index = 0

var counter = 0.2


@onready var temp = preload("res://Gameover/Gameover.tscn")
@onready var nonsense = get_node("Nonsense")
@onready var anim = get_node("Boss")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if fire_reason == 1:
		fire_message = "Jeez, you really aren't a self-starter. I need employees who are always looking for incomplete tasks. You're fired. Go home. Consider yourself lucky, actually. Back in my day, when I was caught slacking my boss would yell 'IF YOU CAN LEAN YOU CAN CLEAN' and beat me upside the head with a broom. Kids these days have no work ethic"
	else:
		fire_message = "You really can't finish this work in a single day? I need employees who work fast, and you seem to be taking it slow. Back in my day, that'd get you sent to a uhhh special school if you catch my drift. No one likes a slowpoke or a lollygagger, learn to pick up the pace. You're fired, go home. \n\nKids these days, no respect."
	message_array = fire_message.split(" ")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter -= delta
	if speaking:
		anim.play()
		if counter <= 0:
			counter = 0.1
			nonsense.text += message_array[speak_index] + " "
			speak_index += 1
			if speak_index >= message_array.size():
				speaking = false
				counter = 0.25
	else:
		anim.pause()
		anim.frame = 0
		if counter <= 0:
			get_parent().add_child(temp.instantiate())
			self.queue_free()
