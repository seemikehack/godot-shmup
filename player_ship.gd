extends Area2D

signal hit

@export var speed = 250 # pixels per second
@export var player_shot_scene: PackedScene
# TODO add special scene

var screen_size
var fire_speed
var heat
var has_special


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("shoot"):
		shoot()
	if Input.is_action_pressed("special"):
		special()
	if Input.is_action_pressed("fire_rate"):
		fire_rate()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	# TODO clamp to bottom half of screen only
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_body_entered(_body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)


# TODO handle heat: dissipation timer, overload and fire suppression, etc.


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func shoot():
	if !$ShotTimer.is_stopped():
		return
	var shot = player_shot_scene.instantiate()
	shot.position = position
	shot.linear_velocity = Vector2.UP # FIXME placeholder vector
	# TODO increment heat according to fire rate
	get_tree().current_child.add_child(shot)
	$ShotTimer.start()


func special():
	# TODO implement
	# instantiate
	# position, rotation, linear_velocity
	# add_child()
	pass


func fire_rate():
	# TODO implement
	pass
