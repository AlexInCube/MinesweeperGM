#macro STAT_GAMES "games"
#macro STAT_WINS "wins"
#macro STAT_BEST_TIME "best_time"
#macro STAT_FILE "stats.ini"

global.difficulties = [
	new DifficultyEasy(),
	new DifficultyMedium(),
	new DifficultyHard()
]

global.current_difficulty = global.difficulties[0]

function ReadStat(difficulty = global.current_difficulty, stat_name){
	var value = 0
	ini_open(STAT_FILE)
	value = ini_read_real(difficulty.internal_name, stat_name, 0)
	ini_close()
	
	return value
}

function WriteStat(difficulty = global.current_difficulty, stat_name, data){
	ini_open(STAT_FILE)
	ini_write_real(difficulty.internal_name, stat_name, data)
	ini_close()
}

function StatisticsShow(){
	var stat_string = "Статистика\n"
	
	for(var i = 0; i < array_length(global.difficulties); i++){
		var difficulty_name = global.difficulties[i].name
		stat_string += "\n[" + string(difficulty_name) + "]"
	
		var games = string(ReadStat(global.difficulties[i], STAT_GAMES))
		if (games <= 0) {
			stat_string += "\nТы не играл(-а) на этой сложности" 
			stat_string += "\n"
			continue
		}
		stat_string += "\nКоличество игр: " + games
		
		var wins = string(ReadStat(global.difficulties[i], STAT_WINS))
		stat_string += "\nПобед: " + wins + " Процент побед: " + string((real(wins)/real(games))*100) + "%"
		
		var time = string(ReadStat(global.difficulties[i], STAT_BEST_TIME))
		if (time == "0") {time = "Ты не побеждал(-а)"}
		stat_string += "\nСамое маленькое время разминирования: " + time
		
		stat_string += "\n"
	}
	
	show_message(stat_string)
}

function StatisticsReset(){
	if (file_exists(STAT_FILE)){
		file_delete(working_directory + "\\" + STAT_FILE)
	}
	
	show_message("Статистика сброшена")
}