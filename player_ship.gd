extends Area2D

signal hit

@export var speed = 250 # pixels per second
@export var heat_capacity = 25;
@export var player_shot_scene: PackedScene
# @export var player_special_scene: PackedScene # TODO

const FIRE_RATES = [ 0.25, 0.125, 0.0625 ]
const HEAT_RATE = 0.25

var screen_size
var fire_rate
var heat
var has_special


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	fire_rate = 0
	heat = 0
	has_special = false
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
	if Input.is_action_just_pressed("special"):
		special()
	if Input.is_action_just_pressed("fire_rate"):
		change_fire_rate()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	# TODO clamp to bottom half of screen only
	position = position.clamp(Vector2.ZERO, screen_size)


func _on_area_entered(_area):
	# TODO implement HP (e.g., takes X hits to kill the player)
	hide()
	hit.emit()
	$CollisionPolygon2D.set_deferred("disabled", true)
	# FIXME input is still processed after ship is hit and hidden


# TODO handle heat: dissipation timer, overload and fire suppression, etc.


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func shoot():
	if !$ShotTimer.is_stopped():
		return
	var shot = player_shot_scene.instantiate()
	shot.position = position + Vector2(0, -25) # crudely shift shot ahead of ship
	# TODO increment heat according to fire rate
	get_tree().current_scene.add_child(shot)
	$ShotTimer.start()


func special():
	# TODO implement
	# instantiate
	# position, rotation, linear_velocity
	# add_c
	pass


func change_fire_rate():
	fire_rate = fire_rate + 1 if fire_rate < 2 else 0
	$ShotTimer.wait_time = FIRE_RATES[fire_rate]
