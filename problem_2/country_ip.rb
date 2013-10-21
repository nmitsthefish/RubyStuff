class CountryIp
  
  def initialize
    @line_array = []
	@country_name = ""
  end
  
  def search(ip_string)
    numerical_ip = IpToNumberConverter.new(ip_string).get_numerical_representation
		File.open("IpToCountry.csv") do |file|
			file.each_line do |line|
				@country_name = CountryExtractor.new(line).get_country_name_from_ip(numerical_ip)
			end
		end
	puts @country_name
	return @country_name
  end
  
end

class IpToNumberConverter
	def initialize(ip)
		@ip_array = ip.split(".")
		@a = @ip_array[0].to_i
		@b = @ip_array[1].to_i
		@c = @ip_array[2].to_i
		@d = @ip_array[3].to_i
		if @ip_array.length != 4 or @a.to_s != @ip_array[0] or @b.to_s != @ip_array[1] or @c.to_s != @ip_array[2] or @d.to_s != @ip_array[3] or @a > 255 or @b > 255 or @c > 255 or @d > 255
			raise ArgumentError, "Invalid IP"
		end
	end
	
	def get_numerical_representation
		return (@d + (@c * 256) + (@b * 256**2) + (@a * 256**3)) 
	end
	
end

class CountryExtractor
	def initialize(line)
		@line_to_parse = line
		@line_array = []
		parse_line
	end
	
	def parse_line
		if @line_to_parse[0] != "#"
			@line_array = @line_to_parse.split(",")
		end
	end
	
	def get_country_name_from_ip(numerical_ip)
		if @line_array.length > 0
			if numerical_ip > @line_array[0].delete("\"").to_i and numerical_ip < @line_array[1].delete("\"").to_i
				
				return @line_array[6].delete("\"").chomp
			end
		end
	end
end

#print CountryIp.new.search("67.252.32.91")
