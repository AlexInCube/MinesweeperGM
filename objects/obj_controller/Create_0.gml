randomize()
event_user(0)

game_in_progress = true

grid_width = global.current_difficulty.grid_width
grid_height = global.current_difficulty.grid_height
total_mines = global.current_difficulty.total_mines

num_flags = 0
cells_remaining = (grid_width * grid_height)

game_zone_width = grid_width * CELL_SIZE
game_zone_height = grid_height * CELL_SIZE

first_turn = true

room_width = game_zone_width + (GAME_ZONE_PADDING * 2)
room_height = game_zone_height + GAME_ZONE_Y + GAME_ZONE_PADDING
window_set_size(room_width, room_height);
surface_resize(application_surface, room_width, room_height);

game_grid = ds_grid_create(grid_width, grid_height)

fill_grid_with_cells()
fill_grid_with_mines()
update_cell_values()

win_message = choose("ПОБЕДА! ВЫ АХУИТЕЛЬНЫ", "НАСЛАЖДАЙСЯ ПОБЕДОЙ", "МОЛОДЕЦ, ТЫ СУПЕР САПЁР", "УЛЬТРА МЕГА ХОРОШ")
lose_message = choose("НЕ ПОВЕЗЛО, НЕ ФАРТАНУЛО", "НЕ РАССТРАИВАЙСЯ", "ЛОШАРА, ТЫ УМЕР", "ВАМ ВЗОРВАЛИ НОГИ")

previous_hover_cell = undefined