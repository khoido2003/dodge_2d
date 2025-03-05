extends Node

@export var mob_scene: PackedScene
var score


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()
	print("Ready")


func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	print("New game started")


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
	print("Start timer")


func _on_score_timer_timeout() -> void:
	score += 1


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene
	var mob = mob_scene.instantiate()

	# Choose a random Location on Path2D
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random Location
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction
	var direction = mob_spawn_location.rotation + PI / 2

	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob
	var velocty = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocty.rotated(direction)

	# Spawn the mob by adding it to the Main scene
	add_child(mob)
	print("mob spawned here (x, y): ", mob.position.x, ",", mob.position.y)
