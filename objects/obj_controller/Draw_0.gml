draw_sprite_stretched(spr_background, 0, GAME_ZONE_X, GAME_ZONE_Y, game_zone_width, game_zone_height)

draw_cells_data()

draw_set_color(c_black)
draw_rectangle(GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + game_zone_width, GAME_ZONE_Y + game_zone_height, true)

if (obj_smile.image_index == 2){
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + game_zone_width, GAME_ZONE_Y + game_zone_height, false)
	draw_set_alpha(1)
	draw_set_font(fnt_main)
	draw_set_color(c_lime)
	draw_text(GAME_ZONE_X + game_zone_width/2, GAME_ZONE_Y + game_zone_height/2, win_message)
	exit
}

if (!game_in_progress){
	draw_set_color(c_black)
	draw_set_alpha(0.5)
	draw_rectangle(GAME_ZONE_X, GAME_ZONE_Y, GAME_ZONE_X + game_zone_width, GAME_ZONE_Y + game_zone_height, false)
	draw_set_alpha(1)
	draw_set_font(fnt_main)
	draw_set_color(c_red)
	draw_text(GAME_ZONE_X + game_zone_width/2, GAME_ZONE_Y + game_zone_height/2, lose_message)
}

