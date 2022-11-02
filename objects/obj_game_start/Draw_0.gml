draw_sprite_stretched(spr_background, 0, GAME_ZONE_PADDING, GAME_ZONE_Y, bg_width, bg_height)


for (var i = 0; i < array_length(global.difficulties); i++) {
	draw_set_color(c_white)
	
	var width = global.difficulties[i].grid_width * CELL_SIZE
	var height = global.difficulties[i].grid_height * CELL_SIZE
	
    draw_rectangle(GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + width, GAME_ZONE_Y + height, true)
}

draw_set_font(fnt_main)

for (var i = 0; i < array_length(global.difficulties); i++) {
	var difficulty = global.difficulties[i]
	var width = difficulty.grid_width * CELL_SIZE
	var height = difficulty.grid_height * CELL_SIZE
	
	if (point_in_rectangle(mouse_x, mouse_y, GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + width, GAME_ZONE_Y + height)){
		draw_set_color(c_aqua)
		draw_rectangle(GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + width, GAME_ZONE_Y + height, true)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		
		var str = difficulty.name + 
			"\nРазмер: " + string(difficulty.grid_width) + "x" + string(difficulty.grid_height) +
			"\nМин: " + string(difficulty.total_mines)
		draw_text(GAME_ZONE_X + width/2, GAME_ZONE_Y + height/2, str)
		
		if (mouse_check_button_pressed(mb_left)){
			global.current_difficulty = difficulty
			room_goto(rm_main)
		}
		
		break
	}
}