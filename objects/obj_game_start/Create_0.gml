


bg_width = global.difficulties[2].grid_width * CELL_SIZE
bg_height = global.difficulties[2].grid_height * CELL_SIZE

room_width = bg_width + (GAME_ZONE_PADDING * 2)
room_height = GAME_ZONE_Y + bg_height + GAME_ZONE_PADDING
window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);