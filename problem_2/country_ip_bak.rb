class CountryIp
  
  def initialize
    @line_array = []
	@country_name = ""
  end
  
  def search(ip_string)
    numerical_ip = IpToNumberConverter.new(ip_string).get_numerical_representation
		File.open("IpToCountry.csv") do |file|
			file.each_line do |line|
				if line[0] != "#"
					@line_array = line.split(",")
					if numerical_ip > @line_array[0].delete("\"").to_i and numerical_ip < @line_array[1].delete("\"").to_i
						@country_name = @line_array[6].delete("\"").chomp
					end
				
				end
			end
		end
	
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
			raise ArgumentError, Errno::ENOENT, "Invalid IP"
		end
	end
	
	def get_numerical_representation
		
		
		return (@d + (@c * 256) + (@b * 256**2) + (@a * 256**3)) 
	end
	
end

#print CountryIp.new.search("67.252.32.91")
