extends Area2D







func _on_AmmoPackArea_area_entered(area):
	if area.is_in_group("Player"):
		PlayerStats.change_ammo(+5)
		queue_free()
