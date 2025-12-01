extends Area2D


@onready var game_manger: Node = %GameManager
@onready var label: Label = $Label

@onready var spark_r: GPUParticles2D = $"spark-r"
@onready var spark_l: GPUParticles2D = $"spark-l"
@onready var saved_sound: AudioStreamPlayer2D = $saved_sound

#	玩家出/入时, 显示/关闭提示信息以及监听相应功能.
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("enter_to_savepoint"):
		body.enter_to_savepoint(self)
		label.visible = true;

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("enter_to_savepoint"):
		body.enter_to_savepoint(null)
		label.visible = false

#	玩家在存档点附近点击存档播放音效/展示粒子效果.
func play_saved():
	spark_r.emitting = true
	spark_l.emitting = true
	saved_sound.play()
