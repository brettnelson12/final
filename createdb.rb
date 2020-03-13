# Set up for the application and database. DO NOT CHANGE. #############################
require "sequel"                                                                      #
connection_string = ENV['DATABASE_URL'] || "sqlite://#{Dir.pwd}/development.sqlite3"  #
DB = Sequel.connect(connection_string)                                                #
#######################################################################################

# Database schema - this should reflect your domain model
DB.create_table! :courses do
  primary_key :id
  String :title
  String :description, text: true
  String :par
  String :location
  String :lat
  String :long
end
DB.create_table! :reviews do
  primary_key :id
  foreign_key :course_id
  foreign_key :user_id
  String :name
  String :email
  Boolean :going 
  String :comments, text: true
end
DB.create_table! :users do
  primary_key :id
  String :name
  String :email
  String :password
end

# Insert initial (seed) data
courses_table = DB.from(:courses)

courses_table.insert(title: "Pebble Beach Golf Links", 
                    description: "Widely regarded as one of the most beautiful courses in the world, it hugs the rugged coastline and has wide open views of Carmel Bay, opening to the Pacific Ocean on the south side of the Monterey Peninsula.",
                    par: "72",
                    location: "Pebble Beach, California",
                    lat: "36.568806",
                    long: "-121.950624")

courses_table.insert(title: "Whistling Straits Golf Course", 
                    description: "Whistling Straits is one of two 36-hole links-style golf courses associated with The American Club, a luxury golf resort located near Sheboygan, Wisconsin, and owned by a subsidiary of the Kohler Company.",
                    par: "72",
                    location: "Sheboygan, Wisconsin",
                    lat: "43.8511",
                    long: "-87.7351")
