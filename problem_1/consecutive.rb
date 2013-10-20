class Consecutive
	
	def initialize(string)
		@string_to_check = string
		@char_count = {}
		@most_consecutive = []
	end
  
	def max_consecutive_characters
		@char_count = CharCounter.new(@string_to_check).count_chars
		@most_consecutive = HashAnalyzer.new(@char_count).determine_most_consecutive
		
		return @most_consecutive.sort
	end
  
end

class CharCounter
	
	def initialize(string)
		@string_to_check = string
		@counter = 1
		@prev_char = ""
		@current_char = ""
		@char_count = {}
	end
	
	def count_chars
		@string_to_check.each_char do |x|
			@current_char = x
			if @current_char == @prev_char
				@counter += 1
			else
				@counter = 1
			end
			if @char_count[x] != nil
				if @counter > @char_count[x]
					@char_count[x] = @counter
				end
			else 
				@char_count[x] = @counter
			end
			@prev_char = @current_char
		end
		
		return @char_count
	end
	
end

class HashAnalyzer
	
	def initialize(hash)
		@char_count = hash
		@most_in_a_row = 0
		@most_consecutive = []
	end
	
	def determine_most_consecutive
		@char_count.each do |pair|
			if pair[1] > @most_in_a_row
				@most_in_a_row = pair[1]
			end
		end
		
		@char_count.each do |pair|
			if pair[1] == @most_in_a_row
				@most_consecutive.push(pair[0])
			end
		end
		
		return @most_consecutive
		
	end
	
end

