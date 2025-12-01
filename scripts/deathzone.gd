extends Area2D


@onready var timer: Timer = $Timer
@onready var game_manger: Node = %GameManager
var player = null

func _on_body_entered(body: Node2D) -> void:
	print(body.is_dead)
	player = body
	if(body.is_dead):
		return
	body.is_dead = true
	
	print("DIE.")
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").disabled = true
	body.animated_sprite.play("die")
	body.get_hit()
	timer.start()
	

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	#await get_tree().reload_current_scene()
	player.is_dead = false
	player.get_node("CollisionShape2D").disabled = false
	player.velocity = Vector2(0,0)
	player.respawn()
	
