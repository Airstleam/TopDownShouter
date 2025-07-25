extends Node2D

@onready var hit_box_component: HitBoxComponent = $HitBoxComponent
@export var anvil_damage: float = 25
@export var spawn_range: float = 100

func _on_timer_timeout() -> void:
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	# Генерация позиции
	var direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	var spawn_position = player.global_position + (direction * randf_range(50, spawn_range))
	
	# Проверка коллизий
	var space_state = get_world_2d().direct_space_state
	var ray_params = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
	var hit = space_state.intersect_ray(ray_params)
	
	if hit:
		spawn_position = hit.position
	
	# Создаем Node2D вместо префаба
	var anvil = Node2D.new()
	anvil.position = spawn_position
	
	# Добавляем HitBoxComponent (если он у вас есть в другом месте)
	var hitbox = HitBoxComponent.new()
	hitbox.damage = anvil_damage
	anvil.add_child(hitbox)
	
	# Добавляем на сцену
	get_tree().get_first_node_in_group("front_layer").add_child(anvil)
