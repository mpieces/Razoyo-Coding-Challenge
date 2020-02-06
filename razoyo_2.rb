@lines = File.new("test-file.txt", "r")
xml = File.open("output_files/customers.xml", 'wb') do |xml|
  result = ""
  result += "<customers>\n"
  @lines.each do |line|
    if line.start_with?('"customer')
      line = line[9..-1].strip
      line = line.gsub('"', '')
      customer_data = line.split(",")    
      output = ""
      output += "<customer>\n"
      output += "<id>#{customer_data[1]}</id>\n"
      output += "<name>#{customer_data[2]}</id>\n"
      output += "<email>#{customer_data[3]}</email>\n"
      output += "<age>#{customer_data[4]}</age>\n"
      if customer_data[5] === "1"
        output += "<gender>male</gender>\n"
      else
        output += "<gender>female</gender>\n"
      end
      output += "</customer>\n"
      result += output
    end
  end
  result += "</customers>\n"
  xml << result
end

xml.close