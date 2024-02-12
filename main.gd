extends Node

const PLAYER_START_POS = Vector2(300,800)

var score


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_mob_timer_timeout():
	pass # Replace with function body.


func game_over():
	$HUD.show_game_over()


func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$PlayerShip.start(PLAYER_START_POS)

	# FIXME these are only here for testing purposes, eventually they should be spawned
	#var cannon_mob = $CannonMob.instantiate()
	#cannon_mob.position = Vector2(150, 150)
	#get_tree().current_scene.add_child(cannon_mob)

	#var bomber_mob = $BomberMob.instantiate()
	#bomber_mob.position = Vector2(450, 150)
	#get_tree().current_scene.add_child(bomber_mob)
	# FIXME
	
	$StartTimer.start()


func _on_cannon_mob_hit():
	score += 1
	$HUD.update_score(score)


func _on_bomber_mob_hit():
	score += 1
	$HUD.update_score(score)
