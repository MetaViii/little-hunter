extends CharacterBody2D

const SPEED = 60
const GRAVITY = 600   # 重力加速度
const MAX_FALL_SPEED = 300  # 最大下落速度

var direction = -1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# 应用重力
	if not is_on_floor():
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_FALL_SPEED:
			velocity.y = MAX_FALL_SPEED
	else:
		velocity.y = 0  # 在地面上时重置下落速度

	# 水平移动逻辑
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	elif ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false

	velocity.x = direction * SPEED

	# 移动并处理碰撞
	move_and_slide()
