extends Button

var timer = 10
var counter = 1.0
@onready var failure = preload("res://Gameover/GettingFired.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter -= delta
	if counter <=0:
		timer -= 1
		counter = 1.0
		if timer <= 0:
			var temp = failure.instantiate()
			temp.fire_reason = 1
			get_parent().get_parent().get_parent().add_child(temp)
			get_parent().get_parent().queue_free()
	self.text = str(timer)


func _on_pressed() -> void:
	timer = 10
	counter = 1.0
