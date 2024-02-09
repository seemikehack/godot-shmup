extends Area2D

signal hit

@export var mob_shot_scene: PackedScene
const SHOT_CHANCE = 0.25
const FIRE_RATE = 0.125


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_shot_timer_timeout():
	if randf() > SHOT_CHANCE:
		return
	for i in 3:
		var shot = mob_shot_scene.instantiate()
		shot.position = position + Vector2(0,25) # crudely shift shot ahead of ship
		shot.linear_velocity = Vector2.DOWN * 500 # TODO parameterize shot speed
		get_tree().current_scene.add_child(shot)
		await get_tree().create_timer(FIRE_RATE).timeout
