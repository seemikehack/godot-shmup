extends Area2D

const SHOT_SPEED = 150

var velocity


# Called when the node enters the scene tree for the first time.
func _ready():
	velocity = Vector2.DOWN * SHOT_SPEED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += velocity * delta
	velocity *= 1.03 # this projectile speeds up over time


func _on_area_entered(_area):
	queue_free()
