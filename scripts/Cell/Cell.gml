function Cell() constructor{
	closed = true
	mine = false
	has_flag = false
	number_of_mines_around = 0
	hover = false
	count = 0
	
	static disable_mine = function(){
		mine = false
		number_of_mines_around = 0
	}
	
	static set_mine = function(){
		mine = true
		number_of_mines_around = -1
	}
	
	static is_mine = function(){
		return mine
	}
	
	static is_flag = function(){
		return has_flag
	}
	
	static switch_flag = function(){
		has_flag = !has_flag
	}
	
	static set_mines_around = function(num){
		number_of_mines_around = num
	}
	
	static get_mines_around = function(){
		return number_of_mines_around
	}
	
	static open = function(){
		closed = false
	}
	
	static is_closed = function(){
		return closed
	}
	
	row = 0
	column = 0
	
	static set_grid_position = function(_r, _c){
		row = _r
		column = _c
	}
	
	xx = 0
	yy = 0
	xx2 = 0
	yy2 = 0
	txt_x = 0
	txt_y = 0
	
	static set_position = function(_x, _y){
		xx = _x
		yy = _y
		xx2 = xx + CELL_SIZE - 1
		yy2 = yy + CELL_SIZE - 1
		txt_x = xx + 3 + CELL_SIZE/2
		txt_y = yy + CELL_SIZE/2
		
		//show_debug_message("Cell: {0}, X: {1}, Y: {2}", count, xx, yy)
	}
	
	static step = function(){
		hover = true
		if (mouse_check_button_pressed(mb_right)){
			obj_controller.set_flag(self)
		}
		if (mouse_check_button_pressed(mb_left)){
			if (!is_closed()){
				obj_controller.open_cells_around_digit(row, column)
				exit
			}
		
			obj_controller.remove_cell(row, column)
		}
	}
	
	static draw = function(){
		if (closed) {
			draw_sprite(spr_cell, hover, xx, yy)

			if (has_flag){
				draw_sprite(spr_flag, 0, xx, yy)
			}
			
			exit
		}
		else if (hover and number_of_mines_around > 0)
		{
			draw_sprite(spr_digits_cell, 0, xx, yy)
		}
		
		if (mine) {
			draw_sprite(spr_mine, 0, xx, yy)
			exit
		}
			
		var color = c_white;
			
		if (number_of_mines_around <= 0) exit
		switch(number_of_mines_around){
			case 1:
	            color = c_aqua
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
		draw_text(txt_x, txt_y, number_of_mines_around)
	}
}