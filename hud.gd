extends CanvasLayer

signal start_game


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()


func update_score(score):
	$Score.text = str(score)


func update_heat(heat):
	$Heat.text = "%04.2f" % heat


func update_fire_rate(rate):
	$FireRate.text = rate


func show_message(msg):
	$Message.text = msg
	$Message.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout

	$Message.text = "SHMUP!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()

