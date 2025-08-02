extends Node2D

@onready var name_spr = get_node("NameBtn/Name")
var name_correct

@onready var dob_spr = get_node("dobBtn/DOB")
var dob_correct

@onready var sex_spr = get_node("SexBtn/Sex")
var sex_correct = false

@onready var id_spr = get_node("IDBtn/ID")
var id_correct

@onready var submit_spr = get_node("SubmitBtn/Submit")

var counter = 0.1
var counting = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if(randf() > 0.75):
		name_correct = false
		name_spr.frame = 1
	else:
		name_correct = true
	
	if(randf() > 0.3):
		dob_correct = false
		dob_spr.frame = randi_range(1,2)
	else:
		dob_correct = true
	
	#sex will always start out as wrong
	sex_spr.frame = 1
	
	if(randf() > 0.1):
		id_correct = false
		id_spr.frame = randi_range(1,2)
	else:
		id_correct = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if counting:
		counter -= delta
	if counter <= 0.0:
		get_parent().task_in_progress = false
		self.queue_free()


func _on_name_btn_pressed() -> void:
	if name_correct:
		name_correct = false
		name_spr.frame = 1
	else:
		name_correct = true
		name_spr.frame = 0


func _on_dob_btn_pressed() -> void:
	if dob_spr.frame == 2:
		dob_spr.frame = 0
		dob_correct = true
	else:
		dob_spr.frame += 1


func _on_sex_btn_pressed() -> void:
	if sex_correct:
		sex_correct = false
		sex_spr.frame = 1
	else:
		sex_correct = true
		sex_spr.frame = 0


func _on_id_btn_pressed() -> void:
	if id_spr.frame == 2:
		id_spr.frame = 0
		id_correct = true
	else:
		id_spr.frame += 1


func _on_submit_btn_pressed() -> void:
	if name_correct and dob_correct and sex_correct and id_correct:
		submit_spr.frame = 2
		counting = true
	else:
		submit_spr.frame = 1
