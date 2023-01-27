if (!game_in_progress) exit 
/*
for (var r = 0; r < grid_width; r++) {
	for (var c = 0; c < grid_height; c++) {
		ds_grid_get(game_grid, r, c).step()
	}
}
*/
if (!is_undefined(previous_hover_cell)){
	previous_hover_cell.hover = false
}

var _xx = floor((mouse_x - GAME_ZONE_X)/CELL_SIZE)*CELL_SIZE
var _yy = floor((mouse_y - GAME_ZONE_Y)/CELL_SIZE)*CELL_SIZE


var row = clamp(floor((_xx) / CELL_SIZE), 0, grid_width - 1) 
var column = clamp(floor((_yy) / CELL_SIZE), 0, grid_height - 1)

if (!point_in_rectangle(mouse_x, mouse_y, GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + game_zone_width, GAME_ZONE_Y + game_zone_height)) exit
if (point_in_rectangle(mouse_x, mouse_y, _xx + GAME_ZONE_X, _yy + GAME_ZONE_Y, _xx + GAME_ZONE_X + CELL_SIZE, _yy + GAME_ZONE_Y + CELL_SIZE)){
	previous_hover_cell = ds_grid_get(game_grid, row, column)
	previous_hover_cell.step()
}

//show_debug_message("MX: {0}, MY: {1}, R: {2}, C: {3}", _xx, _yy, row, column)