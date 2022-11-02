function Cell() constructor{
	closed = true
	mine = false
	has_flag = false
	number_of_mines_around = 0
	hover = false
	
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
}