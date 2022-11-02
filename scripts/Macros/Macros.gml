#macro CELL_SIZE 48
#macro GAME_ZONE_PADDING 10
#macro GAME_ZONE_X GAME_ZONE_PADDING + 0
#macro GAME_ZONE_Y 50

enum cell_state{
	empty,
	standard,
	flag,
	mine
}