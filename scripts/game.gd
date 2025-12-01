extends Node2D

func _ready():
	# 注册场景内的对象到全局 GameManager
	GameManager.set_player($Player)
	GameManager.set_score_label($HUD/Label)

	# 如果有存档则复原位置
	var data = GameManager.load_game()
	if !data.is_empty():
		$Player.position = Vector2(data["position"]["x"], data["position"]["y"])
		GameManager.score = 0  # 或者从存档里恢复分数
