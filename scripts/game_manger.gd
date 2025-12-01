extends Node

var score = 0
#	没有存档的时候的默认信息
var game_status = {
	"is_saved": false,
	"position":{
		"x":0,
		"y":0
	}
}

var player: CharacterBody2D = null
var score_label: Label = null

func set_player(p: CharacterBody2D) -> void:
	player = p

func set_score_label(lbl: Label) -> void:
	score_label = lbl


func add_point():
	score += 1
	if score_label:
		score_label.text = "You collected %d coins." % score


# 存档的读写
func save_game(data: Dictionary)->bool:
	var path = "user://save_.sav"
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
		game_status = load_game()
		print("存档成功.")
		return true
	print("存档失败.")
	return false
	
func load_game()->Dictionary:
	var path = "user://save_.sav"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		if file:
			var data = JSON.parse_string(file.get_as_text())
			file.close()
			return data
	return {}
	

#	载入游戏先读取是否有存档, 无则生成一份默认的.
func _enter_tree() -> void:
	#print(game_status)
	var saved_data = load_game()
	if !saved_data.is_empty():
		game_status = saved_data
	#print(game_status)
