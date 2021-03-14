extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL = Vector2.UP

export var _velocity = Vector2()
export var speed = Vector2(300, 1000)
export var gravity = 3000
export var acceleration = 0.25
export var friction = 0.1
