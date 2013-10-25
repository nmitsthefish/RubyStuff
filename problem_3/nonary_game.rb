class NonaryGame
	SET_TO_ANALYZE = [1,2,3,4,5,6,7,8]
	MAGIC_NUMBER = 5
	MAGIC_DIGITAL_ROOT_VALUE = 9
	MIN_ELEMENTS = 3
	MAX_ELEMENTS = 5
	
  def initialize
    @set = SET_TO_ANALYZE         #set to be analyzed
    @magic_number = MAGIC_NUMBER		#number that must be present in each subset
    @magic_digital_root_value = MAGIC_DIGITAL_ROOT_VALUE #digital root of each subset
    @min_elements = MIN_ELEMENTS  	#minimum number of elements in each subset
    @max_elements = MAX_ELEMENTS #maximum number of elements in each subset
    @temp = []		       #array to manipulate to find solution
    end
    
  def valid_groups
    #from 3 to 5, find all combinations of numbers with each number of elements
    @min_elements.upto(@max_elements) {|x| @temp.push(@set.combination(x).to_a)}
    
    #flatten array by 1 dimension to get a single array with all possible combinations
    all_combinations = @temp.flatten(1)
    
    #keep elements if they include the magic number or have the magic digital root value
    solution = all_combinations.keep_if {|x| has_magic_values?(x, @magic_number, @magic_digital_root_value)}
		
    return solution
  end
	
	def has_magic_values?(array, magic_number, magic_digital_root_value)
		ret_val = false
		digital_root = DigitalRoot.new(array)
		#check if the array of numbers has both the specified magic values
		if array.include?(magic_number) and digital_root.has_value?(magic_digital_root_value)
			ret_val = true
		end
		return ret_val
	end
end

class DigitalRoot
  def initialize(number)
		#check if argument is valid
		check_argument(number)
			
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
	
	def convert_arg_to_string(number)
		#convert all valid inputs to a string
		if number.is_a?(Integer)
      @number = number.to_s
    elsif number.is_a?(Array)
      @number = number.join()
    elsif number.is_a?(String)
      @number = number
		end
	end
	
	def check_argument(number)
		#check if argument is of type String, Integer or Array
		raise ArgumentError, 'Argument must be a String, Integer, or Array' unless 
			number.is_a?(String) || number.is_a?(Integer) || number.is_a?(Array)
    
		#convert the argument to a string for manipulation
    convert_arg_to_string(number)
  
		#check if argument was numeric
		raise ArgumentError, 'Argument must be a numeric value' if
			@number.to_i.to_s != @number
	end
end

	


	
