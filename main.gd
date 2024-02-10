extends Node

@export var cannon_mob_scene: PackedScene
@export var bomber_mob_scene: PackedScene

const PLAYER_START_POS = Vector2(300,800)

var score


# Called when the node enters the scene tree for the first time.
func _ready():
	var cannon_mob = cannon_mob_scene.instantiate()
	cannon_mob.position = Vector2(150, 150)
	get_tree().current_scene.add_child(cannon_mob)

	var bomber_mob = bomber_mob_scene.instantiate()
	bomber_mob.position = Vector2(450, 150)
	get_tree().current_scene.add_child(bomber_mob)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func game_over():
	pass


func new_game():
	score = 0
	$PlayerShip.start(PLAYER_START_POS)
