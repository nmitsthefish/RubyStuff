class Consecutive
	
	def initialize(string)
		@string_to_check = string
		@string_hash = {}
		@most_consecutive = []
	end
  
	def max_consecutive_characters
		@string_hash = CharCounter.new(@string_to_check).count_chars
		@most_consecutive = HashAnalyzer.new(@string_hash).determine_most_consecutive
		
		return @most_consecutive.sort
	end
  
end

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
		
		return @string_hash
	end
	
end

class HashAnalyzer
	
	def initialize(hash)
		@string_hash = hash
		@most_in_a_row = 0
		@most_consecutive = []
	end
	
	def determine_most_consecutive
		@string_hash.each do |pair|
			if pair[1] > @most_in_a_row
				@most_in_a_row = pair[1]
			end
		end
		
		@string_hash.each do |pair|
			if pair[1] == @most_in_a_row
				@most_consecutive.push(pair[0])
			end
		end
		
		return @most_consecutive
		
	end
	
end

