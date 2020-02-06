require 'csv'
require 'pry'


def is_number?(string)
  true if Float(string) rescue false
end

@lines = File.new("test-file.txt", "r")
csv = CSV.open("output_files/products.csv", 'wb', :quote_char=>'*', write_headers: true,
  headers: ["SKU", "Name", "Brand","Price","Currency"]) do |csv|
      @lines.each do |line|
      if line.start_with?('"product')
        line = line[10..-1].strip
        line = line.gsub('"', '')
        product_data = line.split(",")
        product_data[4] ||= "USD"
        product_data = product_data.map do |field|
          if is_number?(field)
              field
          else
            "\"#{field}\""
          end
        end
      
        csv << product_data
      end
  end
end

csv.close

