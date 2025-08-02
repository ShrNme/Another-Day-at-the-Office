extends Node2D

var responses = ["Uh huh", "I understand", "Yes sir", "Ok", "Sure", "I agree"]
var nonsenseWords = ["Blah", "Blee", "Bloo", "Bla", "Bleh", "Solutionize", "bloo", "blah", "ble", "Performance", "bluh", "Client", "Review"]
var affirmations = 0
@onready var response = get_node("ResponseBtn")
@onready var nonsense = get_node("Nonsense")
@onready var animNode = get_node("AnimatedSprite2D")
@onready var debugNode = get_node("debugLabel")
var is_talking = true
@export var talk_interval = 0.1
@export var talk_complete_chance = 0.05
var talk_counter = talk_interval
var just_interupted = false
@onready var affirmationTarget = randi_range(7, 20)

var done = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	debugNode.text = str(affirmations) + "/" + str(affirmationTarget)
	if is_talking:
		animNode.play()
		talk_counter -= delta
		if talk_counter <= 0:
			talk_counter = talk_interval
			nonsense.text = nonsense.text + " " + nonsenseWords.pick_random()
			if talk_complete_chance > randf():
				is_talking = false
				animNode.pause()
				animNode.frame = 0


func _on_response_btn_pressed() -> void:
	if done:
		get_parent().task_in_progress = false
		self.queue_free()
	
	if is_talking:
		is_talking = false
		animNode.pause()
		animNode.frame = 0
		nonsense.text = "Could you please stop interrupting me?"
		response.text = "I'm sorry."
		just_interupted = true
	else:
		if !just_interupted:
			affirmations += 1
		else:
			just_interupted = false
		nonsense.text = ""
		is_talking = true
		response.text = responses.pick_random()
	if affirmations >= affirmationTarget:
		nonsense.text = "It's great we had this conversation, I really feel like I got through to you"
		response.text = "I agree"
		is_talking = false
		done = true
