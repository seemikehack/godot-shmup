extends Area2D

signal hit

@export var mob_shot_scene: PackedScene
const SHOT_CHANCE = 0.25


# Called when the node enters the scene tree for the first time.
func _ready():
	$ShotTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_shot_timer_timeout():
	if randf() > SHOT_CHANCE:
		return
	var shot = mob_shot_scene.instantiate()
	shot.position = position + Vector2(0,25) # crudely shift shot ahead of ship
	get_tree().current_scene.add_child(shot)


func _on_area_entered(_area):
	hit.emit()
	queue_free()
