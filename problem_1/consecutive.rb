class Consecutive
  def initialize(string)
    @string_to_check = string
    @char_count = {}           #hash containing the character and how many consecutive times 
    @most_consecutive = []     #array to store the character(s) that occur the most consecutively
  end
  
  def max_consecutive_characters
    #populate hash from given string
    @char_count = CharCounter.new(@string_to_check).count_chars
		
    #determines the most consecutive with a hash analyzer object
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
    @char_count = {}      #hash containing the characters and how many consecutive times
  end
	
  def count_chars
    @string_to_check.each_char do |x|
      @current_char = x
      #compare current character with the previous character
      if @current_char == @prev_char
        @counter += 1    #increment if same
      else
	@counter = 1     #reset if different
      end
      #assign values to characters in hash
      if @char_count[x] != nil
 	if @counter > @char_count[x]
          @char_count[x] = @counter
	end
      else 
	@char_count[x] = @counter
      end
      #set next previous character
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
    #iterate over hash and find which characters appear consecutively the most
    @char_count.each do |pair|
      if pair[1] > @most_in_a_row
	@most_in_a_row = pair[1]
      end
    end
    #reiterate over hash and populate array with the characters that appear consecutively the most
    @char_count.each do |pair|
      if pair[1] == @most_in_a_row
        @most_consecutive.push(pair[0])
      end
    end
		
    return @most_consecutive
  end
end

