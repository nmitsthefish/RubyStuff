class NonaryGame
	def initialize
		@set = [1,2,3,4,5,6,7,8] #set to be analyzed
		@magic_number = 5        #number that must be present in each subset
		@magic_digital_root_value = 9  #digital root of each subset
		@min_elements = 3        #minimum number of elements in each subset
		@max_elements = 5        #maximum number of elements in each subset
		@temp = []               #array to manipulate to find solution
	end
  
	def valid_groups
		#from 3 to 5, find all combinations of numbers with each number of elements
		@min_elements.upto(@max_elements) {|x| @temp.push(@set.combination(x).to_a)}
		#flatten array by 1 dimension to get a single array with all possible combinations
		#keep elements if they include the magic number or have the magic digital root value
		return @temp.flatten(1).keep_if {|x| x.include?(@magic_number) and DigitalRoot.new(x).has_value?(@magic_digital_root_value)}
	end
end

class DigitalRoot
	def initialize(number)
		#only accept Integer, String, or Array as valid data
		if number.is_a?(Integer)
			@number = number.to_s
		elsif number.is_a?(Array)
			@number = number.join()
		elsif number.is_a?(String)
			@number = number
		else
			raise "Invalid data type"
		end
		#store the digital root of the number
		@digital_root = digital_root_of(@number)
	end

	def digital_root_of(value)
		#if value is 1 digit, it is the digital root
		if value.to_i < 10
			return value.to_i
		end
		#recursively sum each digit of number until it reaches 1 digit
		new_val = 0
		value.each_char do |x|
			new_val += x.to_i
		end
		return digital_root_of(new_val.to_s)
	end	
	
	def has_value?(value)
		#check if the digital root is a specific value
		ret_val = false
		if value == @digital_root
			ret_val = true
		end
		return ret_val
	end	
end







	
