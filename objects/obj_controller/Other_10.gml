function fill_grid_with_cells(){
	var xx = GAME_ZONE_X
	var yy = GAME_ZONE_Y
	
	for (var r = 0; r < grid_width; r++){
	    for (var c = 0; c < grid_height; c++){
			var cell = new Cell()
			game_grid[# r, c] = cell
			
			cell.set_position(xx, yy)		
			cell.set_grid_position(r, c)
			yy += CELL_SIZE

		}
		
		xx += CELL_SIZE
		yy = GAME_ZONE_Y
	}
}

function fill_grid_with_mines(){
	for (var i = 0; i < total_mines; i++) {
		var _x = irandom(grid_width - 1)
		var _y = irandom(grid_height - 1)
		
		var cell = game_grid[# _x, _y]
		
		if (!cell.is_mine()){
			cell.set_mine()
		}else{
			i--
		}
	}
}

function check_cell_is_mine(_x, _y){
	if (_x < 0 or _x > grid_width - 1){
		return false
	}
	
	if (_y < 0 or _y > grid_height - 1){
		return false
	}
	
	return game_grid[# _x,_y].is_mine()
}

function check_cell_is_flag(_x, _y){
	if (_x < 0 or _x > grid_width - 1){
		return false
	}
	
	if (_y < 0 or _y > grid_height - 1){
		return false
	}
	
	return game_grid[# _x,_y].is_flag()
}

function update_cell_values(){
	// Update Cell Values
	for (var xx = 0; xx < grid_width; xx++){
	    for (var yy = 0; yy < grid_height; yy++){
	        // Check adjacent cell values
			var current_check_cell = game_grid[# xx,yy]
	        if (!current_check_cell.is_mine()){
	            var num_of_mines = 0;
            
	            // Check Top_Left
	            if (check_cell_is_mine(xx-1, yy-1)) num_of_mines++;
	            // Check Top
	            if (check_cell_is_mine(xx, yy-1)) num_of_mines++;
	            // Check Top_Right
				if (check_cell_is_mine(xx+1, yy-1)) num_of_mines++;
	            // Check Left
				if (check_cell_is_mine(xx-1, yy)) num_of_mines++;
	            // Check Right
				if (check_cell_is_mine(xx+1, yy)) num_of_mines++;
	            // Check Bot_Left
				if (check_cell_is_mine(xx-1, yy+1)) num_of_mines++;
	            // Check Bot
				if (check_cell_is_mine(xx, yy+1)) num_of_mines++;
	            // Check Bot_Right
				if (check_cell_is_mine(xx+1, yy+1)) num_of_mines++;
            
	            // Assign Cell Value
	            current_check_cell.set_mines_around(num_of_mines)
	        }
	    }
	}
}

function move_mine(_x, _y){
	var init_cell = game_grid[# _x, _y]
	
	if (!init_cell.is_mine()) exit
	
	while (true){
		//show_debug_message("cell is mine")
		var new_x = irandom(grid_width - 1)
		var new_y = irandom(grid_height - 1)
		var cell = game_grid[# new_x, new_y]
		
		if (cell.is_mine()) continue
		
		cell.set_mine()
		init_cell.disable_mine()
		break
	}
	
	update_cell_values()
}

function remove_cell(_x, _y){
	if (first_turn){
		move_mine(_x, _y)
		first_turn = false
	}
		
	var cell = game_grid[# _x, _y]
    // Disable Flag Clicks
    if (cell.is_closed() and !cell.is_flag()){
        // Detonate cells with mine
        if (cell.is_mine()){
			lose_game()
        } else {
            clear_cells(_x, _y);
			win_game()
        }
    }
}

function set_flag(cell){
	cell.switch_flag()
	if (cell.is_flag()) num_flags++ else num_flags--
}

function draw_cells_data(){
	draw_set_font(fnt_main)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)

	for (var r = 0; r < grid_width; r++) {
		for (var c = 0; c < grid_height; c++) {
			game_grid[# r, c].draw()
		}
	}
}

function lose_game(){
	game_in_progress = false
	obj_smile.image_index = 1
	WriteStat(undefined, STAT_GAMES, ReadStat(undefined, STAT_GAMES) + 1)
    // Display Bombs
    for (var xx = 0; xx < grid_width; xx++){
		for (var yy = 0; yy < grid_height; yy++){
            if (game_grid[# xx,yy].is_mine()){
                game_grid[# xx,yy].open()
            }
        }
    }
}

function win_game(){
	if (cells_remaining == total_mines){
		obj_smile.image_index = 2
		game_in_progress = false
										
		WriteStat(undefined, STAT_GAMES, ReadStat(undefined, STAT_GAMES) + 1)
		WriteStat(undefined, STAT_WINS, ReadStat(undefined, STAT_WINS) + 1)
					
		var init_time = ReadStat(undefined, STAT_BEST_TIME)

		if (init_time == 0) { 
			WriteStat(undefined, STAT_BEST_TIME, obj_smile.seconds)
		} else if (init_time > obj_smile.seconds){
			WriteStat(undefined, STAT_BEST_TIME, obj_smile.seconds)
		}
	}
}

function open_cells_around_digit(_r, _c){
	var cell = game_grid[# _r, _c]
	if cell.is_closed() exit

	function open_single_cell(_r, _c){
		if (_r < 0 or _r > grid_width - 1){
			exit
		}
	
		if (_c < 0 or _c > grid_height - 1){
			exit
		}
	
		if (game_grid[# _r, _c].is_flag()) exit
	
		game_grid[# _r, _c].open()
	
		if (game_grid[# _r, _c].is_mine()){
			lose_game()
		}
	}

	var num_of_flags = 0
	// Check Top_Left
	if (check_cell_is_flag(_r-1, _c-1)) num_of_flags++;
	// Check Top
	if (check_cell_is_flag(_r, _c-1)) num_of_flags++;
	// Check Top_Right
	if (check_cell_is_flag(_r+1, _c-1)) num_of_flags++;
	// Check Left
	if (check_cell_is_flag(_r-1, _c)) num_of_flags++;
	// Check Right
	if (check_cell_is_flag(_r+1, _c)) num_of_flags++;
	// Check Bot_Left
	if (check_cell_is_flag(_r-1, _c+1)) num_of_flags++;
	// Check Bot
	if (check_cell_is_flag(_r, _c+1)) num_of_flags++;
	// Check Bot_Right
	if (check_cell_is_flag(_r+1, _c+1)) num_of_flags++;
	
	if cell.get_mines_around() <= num_flags{
		open_single_cell(_r-1, _c-1)
		open_single_cell(_r, _c-1)
		open_single_cell(_r + 1, _c-1)
		open_single_cell(_r - 1, _c)
		open_single_cell(_r + 1, _c)
		open_single_cell(_r -1, _c + 1)
		open_single_cell(_r, _c+1)
		open_single_cell(_r+1, _c+1)
	}
}

