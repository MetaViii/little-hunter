extends Area2D

@onready var game_manger: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _on_body_entered(body: Node2D) -> void:
	game_manger.add_point()
	animation_player.play("pickup")
