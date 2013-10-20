class CharCounter
	def initialize(string)
		@string_to_check = string
		@counter = 1
		@prev_char = ""
		@current_char = ""
		@string_hash = {}
	end
	
	def count_chars
		@string_to_check.each_char do |x|
			@current_char = x
			if @current_char == @prev_char
				@counter += 1
			else
				@counter = 1
			end
			if @string_hash[x] != nil
				if @counter > @string_hash[x]
					@string_hash[x] = @counter
				end
			else 
				@string_hash[x] = @counter
			end
			@prev_char = @current_char
		end
	end
	
end


class Consecutive
	
	def initialize(string)
		@string_to_check = string
		@string_hash = {}
		@counter = 1
		@prev_char = ""
		@current_char = ""
		@biggest = 0
		@most_consecutive = []
		# Implement me
	end
  
	def max_consecutive_characters
		@string_to_check.each_char do |x|
			@current_char = x
			if @current_char == @prev_char
				@counter += 1
			else
				@counter = 1
			end
			if @string_hash[x] != nil
				if @counter > @string_hash[x]
					@string_hash[x] = @counter
				end
			else 
				@string_hash[x] = @counter
			end
			@prev_char = @current_char
		end
		
		@string_hash.each do |pair|
			if pair[1] > @biggest
				@biggest = pair[1]
			end
		end
		
		@string_hash.each do |pair|
			if pair[1] == @biggest
				@most_consecutive.push(pair[0])
			end
		end
		
		return @most_consecutive.sort
		# Implement me
	end
  
end
