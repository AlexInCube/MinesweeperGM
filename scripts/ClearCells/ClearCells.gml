function cell_is_autodestroyable(_x, _y){
	if (_x < 0 or _x > grid_width - 1){
		return false
	}
	
	if (_y < 0 or _y > grid_height - 1){
		return false
	}
	
	return game_grid[# _x,_y].is_closed() and game_grid[# _x,_y].get_mines_around() >= 0
}

function clear_cells(_x, _y) {
	var cell = game_grid[# _x, _y]

	// Destroy current Cell
	if (cell.is_closed) {
		cell.open()
		cells_remaining--
	}
	
	if (cell.get_mines_around() > 0) exit

	function try_destroy_cells(_xx, _yy){
		if (cell_is_autodestroyable(_xx, _yy)){
		    game_grid[# _xx, _yy].open()
			clear_cells(_xx, _yy);
		}
	}
	// Top Left
	try_destroy_cells(_x - 1, _y - 1)
	// Top
	try_destroy_cells(_x, _y - 1)
	// Top Right
	try_destroy_cells(_x + 1, _y - 1)
	// Left
	try_destroy_cells(_x - 1, _y)
	// Right
	try_destroy_cells(_x + 1, _y)
	// Bot Left
	try_destroy_cells(_x - 1, _y + 1)
	// Bot
	try_destroy_cells(_x, _y + 1)
	// Bot Right
	try_destroy_cells(_x + 1, _y + 1)
}