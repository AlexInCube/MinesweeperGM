function ParDifficulty() constructor{
	grid_width = 0
	grid_height = 0
	total_mines = 0
	name = "unknown difficulty"
	internal_name = "unknown"
}

function DifficultyEasy() : ParDifficulty() constructor{
	grid_width = 8
	grid_height = 8
	total_mines = 10
	name = "Легко"
	internal_name = "easy"
}

function DifficultyMedium() : ParDifficulty() constructor{
	grid_width = 13
	grid_height = 15
	total_mines = 40
	name = "Средне"
	internal_name = "medium"
}

function DifficultyHard() : ParDifficulty() constructor{
	grid_width = 30
	grid_height = 16
	total_mines = 99
	name = "Сложно"
	internal_name = "hard"
}
