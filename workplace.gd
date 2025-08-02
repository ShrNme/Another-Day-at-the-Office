extends Node2D

@onready var clockLabel = get_node("Clock")
@onready var taskLabel = get_node("TaskList")
@onready var failure = preload("res://Gameover/GettingFired.tscn")
@onready var success = preload("res://Success/Success.tscn")
#var taskDict = {} #Formatted as "Text to appear on the list":"SceneToSpawn.tscn"
var taskArray = []
var taskScenesArray = []

var minute = 0
var hour = 8
var second_counter = 0.1
var task_in_progress = false
var lookbusy = preload("res://LookBusy/LookBusy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#taskDict = {"Shred Documents":"PaperShredding.tscn"}
	taskArray = ["Filler entry cuz I'm dumb","Shred the documents", "Send the apology email", "Fix the printer", "Attend the meeting", "Correct form entry", "Make phone calls"]
	taskScenesArray = ["Filler entry",preload("res://PaperShredding/PaperShredding.tscn"), preload("res://ApologyEmail/ApologyEmail.tscn"), preload("res://PrinterRepair/PrinterRepair.tscn"), preload("res://Meeting/Meeting.tscn"), preload("res://CorrectFormEntry/CorrectFormEntry.tscn"), preload("res://PhoneCalls/PhoneCalls.tscn")]
	clockLabel.text = "8:00"
	setLabel()

func startTask():
	#get task from the list
	#when the game is complete, the list will be randomized
	if taskScenesArray.size()>0:
		var temp = taskScenesArray[0]
		var temp2 = temp.instantiate()
		add_child(temp2)
		task_in_progress = true
	else:
		var temp = lookbusy.instantiate()
		add_child(temp)
		task_in_progress = true
	
func setLabel():
	taskLabel.text = "Today's Tasks:"
	for i in taskArray:
		taskLabel.text += "\n" +i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	second_counter -= delta
	if second_counter <= 0:
		second_counter = 0.20
		minute += 1
		if minute >= 60:
			hour += 1
			minute = 0
			if hour >= 13:
				hour = 1
		#turn the time into a string for the clock label
		if minute < 10:
			clockLabel.text = str(hour) + ":0" +str(minute)
		else:
			clockLabel.text = str(hour) + ":" + str(minute)
	
	if !task_in_progress:
		taskArray.remove_at(0)
		taskScenesArray.remove_at(0)
		setLabel()
		startTask()
	
	if hour == 4 and minute >=30:
		if taskScenesArray.size() == 0:
			add_sibling(success.instantiate())
			self.queue_free()
		else:
			add_sibling(failure.instantiate())
			self.queue_free()
		
