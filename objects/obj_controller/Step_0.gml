if (!game_in_progress) exit 

for (var r = 0; r < grid_width; r++) {
	for (var c = 0; c < grid_height; c++) {
		var cell = game_grid[# r, c]
		var cell_world_x = GAME_ZONE_X + (r * CELL_SIZE)
		var cell_world_y = GAME_ZONE_Y + (c * CELL_SIZE)
		cell.hover = false
		if (point_in_rectangle(mouse_x, mouse_y, cell_world_x, cell_world_y, cell_world_x + CELL_SIZE - 1, cell_world_y + CELL_SIZE - 1)){
			
			cell.hover = true
			set_flag(cell)
			remove_cell(r, c)
		}
	}
}

