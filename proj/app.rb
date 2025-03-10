require 'pg'
require 'json'
str = ARGV.join(' ')
#puts str

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
  #result = conn.exec('select * from categories') 
result = conn.exec(str) 

  # Iterate over the result set and print each row
  result.each do |row|
    #puts row.to_json
     puts row
  end

rescue PG::Error => e
  puts "An error occurred: #{e.message}"
ensure
  # Close the connection
  conn.close if conn
end

#ruby app.rb 'select * from categories'
