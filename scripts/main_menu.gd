extends Control

@onready var new_game_btn: Button = $CenterContainer/VBoxContainer/Button1
@onready var continue_btn: Button = $CenterContainer/VBoxContainer/Button2
@onready var about_btn: Button = $CenterContainer/VBoxContainer/Button3
@onready var quit_btn: Button = $CenterContainer/VBoxContainer/Button4



func _ready():
	# 设置按钮文字
	new_game_btn.text = "新 游 戏"
	continue_btn.text = "继 续 游 戏"
	about_btn.text = "关 于 我 们"
	quit_btn.text = "退 出"

	# 绑定按钮事件
	new_game_btn.pressed.connect(_on_new_game)
	continue_btn.pressed.connect(_on_continue)
	about_btn.pressed.connect(_on_about)
	quit_btn.pressed.connect(_on_quit)
	
	# 设置统一样式
	_apply_button_style(new_game_btn)
	_apply_button_style(continue_btn)
	_apply_button_style(about_btn)
	_apply_button_style(quit_btn)
	
	# 判断存档是否存在，如果没有就禁用“继续游戏”按钮
	var save_path = "user://save_.sav"
	if not FileAccess.file_exists(save_path):
		continue_btn.disabled = true   # 变灰不可点


func _apply_button_style(btn: Button):
	btn.custom_minimum_size = Vector2(230, 60)  # 按钮最小大小（宽，高）
	
	var style = StyleBoxFlat.new()
	style.bg_color = Color(0.2, 0.4, 0.6, 0.8)
	

	# 圆角
	style.corner_radius_top_left = 12
	style.corner_radius_top_right = 12
	style.corner_radius_bottom_left = 12
	style.corner_radius_bottom_right = 12

	# 边框
	style.border_width_left = 2
	style.border_width_top = 2
	style.border_width_right = 2
	style.border_width_bottom = 2
	style.border_color = Color(1, 1, 1, 0.8)

	# 普通状态
	btn.add_theme_stylebox_override("normal", style)

	# 悬停状态
	var hover_style = style.duplicate()
	hover_style.bg_color = Color(0.3, 0.6, 0.9, 0.9)
	btn.add_theme_stylebox_override("hover", hover_style)

	# 按下状态
	var pressed_style = style.duplicate()
	pressed_style.bg_color = Color(0.1, 0.2, 0.4, 0.9)
	btn.add_theme_stylebox_override("pressed", pressed_style)

	# 字体配置
	var font = FontFile.new()
	font = load("res://assets/fonts/zihun.ttf")  # 加载字体文件
	btn.add_theme_font_override("font", font)

# 新游戏：清空进度，删除存档文件，进入游戏场景
func _on_new_game():
	# 删除本地存档
	var save_path = "user://save_.sav"
	if FileAccess.file_exists(save_path):
		DirAccess.remove_absolute(ProjectSettings.globalize_path(save_path))
		print("已删除旧存档")

	# 重置游戏状态
	GameManager.game_status = {
		"is_saved": false,
		"position": {"x": 0, "y": 0}
	}
	GameManager.score = 0
	print("开始新游戏")

	# 切换到游戏场景
	get_tree().change_scene_to_file("res://scenes/game.tscn")


# 继续游戏：读取存档并进入游戏
func _on_continue():
	var loaded = GameManager.load_game()
	if !loaded.is_empty():
		GameManager.game_status = loaded
		print("继续游戏，存档数据:", loaded)
		get_tree().change_scene_to_file("res://scenes/game.tscn")
	else:
		print("没有找到存档文件")

# 关于我们：显示一个弹窗
func _on_about():
	var dialog = AcceptDialog.new()
	dialog.title = "关于本游戏"
	dialog.dialog_text = "✨ 制作人：MetaVi✨\n✨ 协力：超级小马✨\n\n感谢游玩！"
	
	# 自定义大小
	dialog.min_size = Vector2(320, 180)
	
	# 自定义主题样式（圆角 + 背景）
	var style_box = StyleBoxFlat.new()
	style_box.bg_color = Color(0.15, 0.2, 0.25, 0.95)
	style_box.corner_radius_top_left = 12
	style_box.corner_radius_top_right = 12
	style_box.corner_radius_bottom_left = 12
	style_box.corner_radius_bottom_right = 12
	dialog.add_theme_stylebox_override("panel", style_box)
	
	# 字体（直接 load 字体资源，不要 .new()）
	var font: Font = load("res://assets/fonts/zihun.ttf")
	if font:
		dialog.add_theme_font_override("font", font)
	
	# 修改按钮样式
	var ok_btn = dialog.get_ok_button()
	ok_btn.text = "好耶"
	
	add_child(dialog)
	dialog.popup_centered()



# 退出游戏
func _on_quit():
	get_tree().quit()
