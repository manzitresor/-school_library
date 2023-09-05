require './app'
app = App.new

def main(app)
  app.load_data
  puts 'Welcome to School Library App!'
  loop do
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'

    number = gets.chomp.to_i
    execute_option(app, number)
    break if number == 7
  end
end

def execute_option(app, number)
  case number
  when 1
    app.list_all_books
  when 2
    app.list_all_people
  when 3
    app.create_person
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.get_rental_option
  when 7
    app.save_data
  end
end

main(app)
