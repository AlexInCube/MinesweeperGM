function fill_grid_with_cells(){
	for (var xx = 0; xx < grid_width; xx++){
	    for (var yy = 0; yy < grid_height; yy++){
			game_grid[# xx,yy] = new Cell()
		}
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
	
	if (!init_cell.is_mine()) { show_debug_message("cell is empty"); exit}
	
	while (true){
		show_debug_message("cell is mine")
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
	if (mouse_check_button_pressed(mb_left)){
		if (first_turn){
			move_mine(_x, _y)
			first_turn = false
		}
		
		var cell = game_grid[# _x, _y]
        // Disable Flag Clicks
        if (cell.is_closed() and !cell.is_flag()){
            // Detonate cells with mine
            if (cell.is_mine()){
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
            } else {
                clear_cells(_x, _y);

				if (cells_remaining == total_mines){
				    obj_smile.image_index = 2
					game_in_progress = false
										
					WriteStat(undefined, STAT_GAMES, ReadStat(undefined, STAT_GAMES) + 1)
					WriteStat(undefined, STAT_WINS, ReadStat(undefined, STAT_WINS) + 1)
					
					var init_time = ReadStat(undefined, STAT_BEST_TIME)

					if (init_time == 0) { 
						WriteStat(undefined, STAT_BEST_TIME, round(obj_smile.seconds))
					} else if (init_time > obj_smile.seconds){
						WriteStat(undefined, STAT_BEST_TIME, round(obj_smile.seconds))
					}
				}
            }
        }
    }
}

function set_flag(cell){
	if (mouse_check_button_pressed(mb_right)){
	    cell.switch_flag()
		if (cell.is_flag()) num_flags++ else num_flags--
		
	}
}

function draw_cells_data(){
	draw_set_font(fnt_main)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)

	for (var r = 0; r < grid_width; r++) {
		for (var c = 0; c < grid_height; c++) {
			var xx = (x + CELL_SIZE * r) + GAME_ZONE_X
			var yy = (y + CELL_SIZE * c) + GAME_ZONE_Y
			var cell = game_grid[# r, c]
			
			if (cell.is_closed()) {
				draw_sprite(spr_cell, cell.hover, xx, yy)
				
				if (cell.is_flag()){
					draw_sprite(spr_flag, 0, xx, yy)
				}
				continue
			}
			
			if (cell.is_mine()) {
				draw_sprite(spr_mine, 0, xx, yy)
				continue
			}
			
			var color = c_white;
			var mines_count = cell.get_mines_around()
			
			if (mines_count <= 0) continue
			switch(mines_count){
				case 1:
	                color = c_blue
	                break;
	            case 2:
	                color = c_lime;
	                break;
	            case 3:
	                color = c_red;
	                break;
	            case 4:
	                color = c_purple;
	                break;
	            case 5:
	                color = c_maroon;
	                break;
	            case 6:
	                color = c_teal;
	                break;
	            case 7:
	                color = c_black;
	                break;
	            case 8:
	                color = c_gray;
	                break;
			}
		
			draw_set_color(color)
			draw_text(xx + 3 + CELL_SIZE/2, yy + CELL_SIZE/2, mines_count)
		}
	}
}