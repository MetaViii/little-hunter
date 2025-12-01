extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manger: Node = %GameManager
## 射线检测碰撞
#@onready var ray_from_head: RayCast2D = $rayFromHead
#@onready var ray_from_foot: RayCast2D = $rayFromFoot
# 滞空时间/冲刺时间计时器.
@onready var timer_in_air: Timer = $TimerInAir
@onready var timer_in_dash: Timer = $TimerInDash

# 角色数值设定
const SPEED = 120.0
const JUMP_VELOCITY = -300.0
const DASH_VELOCITY = 840
const DASH_GRAVITY_SCALE = 0.0  # 冲刺期间重力为0
const HANGING_GRAVITY_SCALE = 0.2  # 滞空期间重力缩放

# 角色状态
var in_savepoint = null
var is_dead = false
var can_input = true
var is_dashing = false
var is_hanging = false
var dash_direction = 0  # 冲刺方向，1为右，-1为左
var last_on_floor_state = false
var can_dash = true

#	对上一帧玩家运动方向的记录, 用以当前受击后判断反向受击动画
var direction

func _physics_process(delta: float) -> void:
	last_on_floor_state = is_on_floor()
	
	
	# 基础重力应用
	if not is_dashing:
		if is_hanging:
			velocity += get_gravity() * HANGING_GRAVITY_SCALE * delta
		else:
			velocity += get_gravity() * delta
	
	# 死亡状态无后续操作
	if is_dead:
		velocity.x = move_toward(velocity.x, 0, 6)
		move_and_slide()
		return
	
	# 空中冲刺期间的运动逻辑
	if is_dashing:
		velocity.x = move_toward(velocity.x, 0, 60)
		velocity.y = 0  # 冲刺时竖直速度为0
		move_and_slide()
		return
	
	# 滞空期间不处理输入
	if is_hanging:
		move_and_slide()
		return
	
	# 回到地面则恢复输入
	if (!can_input || !can_dash) && is_on_floor():
		can_input = true
		can_dash = true
		print("1")
	if !can_input:
		move_and_slide()
		return
	
	# dash(左shift), 进入滞空状态
	if Input.is_action_just_pressed("dash") && can_dash:
		Engine.time_scale = 0.2
		timer_in_air.start()
		is_hanging = true
		can_input = false
		can_dash = false
		# 记录当前面向方向作为冲刺方向
		dash_direction = -1 if animated_sprite.flip_h else 1
		return
	
	# 跳跃处理
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# 水平移动
	direction = Input.get_axis("move_left", "move_right")
	
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# 动画控制
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()


func _process(delta: float) -> void:
	# 处理"F"键交互逻辑.
	if Input.is_action_just_pressed("interact") && in_savepoint != null:
		in_savepoint.play_saved()
		game_manger.save_game(
			{"is_saved": true, "position": {"x": position.x, "y": position.y}}
		)


# 供savepoint实例调用
func enter_to_savepoint(savepoint: Area2D):
	in_savepoint = savepoint


func _on_timer_in_air_timeout() -> void:
	print("滞空结束，开始冲刺.")
	timer_in_air.stop()
	Engine.time_scale = 1
	is_hanging = false
	
	timer_in_dash.start()
	is_dashing = true
	animated_sprite.play("dash")
	velocity.x = dash_direction * DASH_VELOCITY


func _on_timer_in_dash_timeout() -> void:
	is_dashing = false
	can_input = true
	# 冲刺结束后重置竖直速度，防止影响后续跳跃
	velocity.y = -40
	velocity.x = -dash_direction*SPEED*0.3
	timer_in_dash.stop()

#	进入对象树时, 立刻设置正确地位置.
func _enter_tree() -> void:
	respawn()
		
func respawn():
	print("respawn")
	var game_manger: Node = %GameManager
	print(game_manger.game_status['position'])
	if game_manger != null:
		var status_position = game_manger.game_status['position']
		position.x = status_position['x']
		position.y = status_position['y']
		

#	玩家受击
func get_hit():
	velocity = Vector2(direction*JUMP_VELOCITY, JUMP_VELOCITY*0.6)
