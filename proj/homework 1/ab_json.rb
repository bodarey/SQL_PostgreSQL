# frozen_string_literal: true

require 'pg'
require 'json'
require_relative 'library'
hh = []
# puts str

# Connection parameters
conn_params = {
  host: 'localhost',  # Replace with your database host
  dbname: 'postgres', # Replace with your database name
  user: 'postgres',   # Replace with your database username
  password: 'fraer'   # Replace with your database password
}

begin
  # Establish a connection to the database
  conn = PG.connect(conn_params)

  # Execute a SELECT query
  # result = conn.exec('select * from categories')
  1.upto(8) do |i|
    result = conn.exec(Library.query(i))
   

    # Iterate over the result set and print each row
    result.each do |row|
      hh << row
      
    end
  end
rescue PG::Error => e
  puts "An error occurred: #{e.message}"
ensure
  # Close the connection
  conn&.close
end

#puts hh.to_json
#puts JSON.pretty_generate(hh)


#puts " #{k} #{v}"   
puts JSON.pretty_generate(hh)


