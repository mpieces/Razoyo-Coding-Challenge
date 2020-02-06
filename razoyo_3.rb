require 'json'
require 'pry'

orders = []
current_order_id = nil
@lines = File.new("test-file.txt", "r")
  @lines.each do |line|
    if line[0..5] == '"order' && line[6..10] != "-line"
      line = line[8..-1].strip
      line = line.gsub('"', '')
      order_data = line.split(",")
      current_order_id = order_data[0]
      order = {
        "id" => current_order_id,
        "head" => {
          "sub_total" => order_data[2],
          "tax" => order_data[3],
          "total" => order_data[4],
          "customer_id" => order_data[5]
        },
        "lines" => []
      }
      orders << order
    elsif line[0..10] == '"order-line'
      line = line[13..-1].strip
      line = line.gsub('"', '')
      order_line_data = line.split(",")
      order_line = {
        "position" => order_line_data[0],
        "name" => order_line_data[1],
        "price" => order_line_data[2],
        "quantity" => order_line_data[3],
        "row_total" => order_line_data[2].to_f * order_line_data[3].to_f
      }
      current_order = orders.find { |order| order["id"] == current_order_id }
      current_order["lines"] << order_line
    end
  end

json_file = File.open("output_files/orders.json","w") do |f|
  f.write(JSON.pretty_generate(orders))
end