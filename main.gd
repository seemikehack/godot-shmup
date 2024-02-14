extends Node

@export var cannon_mob_scene: PackedScene
@export var bomber_mob_scene: PackedScene

const PLAYER_START_POS = Vector2(300,800)

var score


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_start_timer_timeout():
	# FIXME for testing only, eventually MobTimer will spawn them
	var cannon_mob = cannon_mob_scene.instantiate()
	cannon_mob.position = Vector2(150, 150)
	cannon_mob.hit.connect(_on_mob_hit)
	get_tree().current_scene.add_child(cannon_mob)

	var bomber_mob = bomber_mob_scene.instantiate()
	bomber_mob.position = Vector2(450, 150)
	bomber_mob.hit.connect(_on_mob_hit)
	get_tree().current_scene.add_child(bomber_mob)


# connected in code
func _on_mob_hit():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	# TODO start spawning mobs
	pass # Replace with function body.


func _on_player_ship_fire_rate_changed():
	$HUD.update_heat($PlayerShip.heat)


func _on_player_ship_shots_fired():
	$HUD.update_fire_rate($PlayerShip.FIRE_RATE_STRS[$PlayerShip.fire_rate])


func game_over():
	$HUD.show_game_over()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$PlayerShip.start(PLAYER_START_POS)
	$StartTimer.start()
