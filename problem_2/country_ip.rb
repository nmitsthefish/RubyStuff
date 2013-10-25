class CountryIp
  
  def initialize 
    @line_array = []
    @country_name = ""
    @file = "IpToCountry.csv"
  end
  
  def search(ip_string)
    #determine the numerical value of the IP address
    numerical_ip = IpToNumberConverter.new(ip_string).get_numerical_representation

    #find the country in the IP List with IP given
    @country_name = CountryExtractor.new(@file).get_country_name_from_ip(numerical_ip)
	  
    #return country name
    return @country_name
  end
end

class IpToNumberConverter
  def initialize(ip)
    #split IP address into its 4 components and put in array
    @ip_array = ip.split(".")
		
    #convert each string value to its integer value
    @a = @ip_array[0].to_i
    @b = @ip_array[1].to_i
    @c = @ip_array[2].to_i
    @d = @ip_array[3].to_i
		
    #check conditions to make sure IP address is valid, raise exception if invalid
    if @ip_array.length != 4 or 
       @a.to_s != @ip_array[0] or 
       @b.to_s != @ip_array[1] or 
       @c.to_s != @ip_array[2] or 
       @d.to_s != @ip_array[3] or 
       @a > 255 or 
       @b > 255 or 
       @c > 255 or 
       @d > 255 or 
       @a < 0 or 
       @b < 0 or 
       @c < 0 or 
       @d < 0
         raise ArgumentError, "Invalid IP"
    end
  end
	
  def get_numerical_representation
    #Numerical representation of IP address.
    #Example: (from Right to Left)
    #1.2.3.4 = 4 + (3 * 256) + (2 * 256 * 256) + (1 * 256 * 256 * 256)
    return (@d + (@c * 256) + (@b * 256**2) + (@a * 256**3)) 
  end
end

class CountryExtractor
  def initialize(file)
    @ip_list = file
    @line_array = []
  end
	
  def get_country_name_from_ip(numerical_ip)
    #open file containing IP list
    File.open(@ip_list) do |file|
      file.each_line do |line|
        #disregard commented lines
	if line[0] != "#"
	  #split each entry into its components
	  @line_array = line.split(",")
	  #return country name if numerical IP is within the values of that entry
	  if numerical_ip > @line_array[0].delete("\"").to_i and numerical_ip < @line_array[1].delete("\"").to_i
	    return @line_array[6].delete("\"").chomp
	  end
	end
      end
    end
  end
end
