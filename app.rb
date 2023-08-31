require_relative 'book'
require_relative 'classroom'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'
class App
  def initialize
    @books = []
    @people = []
  end

  def run
    puts 'Welcome to School Library App!'
    list_options
  end

  def list_options
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
      case number
      when 1..6 then execute_option(number)
      when 7 then puts 'Thank you for using this app!'
      end
      break if number == 7
    end
  end

  def execute_option(response)
    case response
    when 1
      list_all_books
    when 2
      list_all_people
    when 3
      create_person_option
    when 4
      create_book_option
    when 5
      create_rental
    when 6
      rental_option
    end
  end

  def create_person(person_code)
    if person_code == 1
      create_student
    elsif person_code == 2
      create_teacher
    else
      puts ' invalid input'
      call(3)
    end
    puts 'Person created successfully'
  end

  def create_student
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    has_permission = gets.chomp
    permission_values = %w[n N]
    student = Student.new(age, name, permission_values.include?(has_permission))
    @people.push(student)
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    @people.push(teacher)
  end

  def create_book(title, author)
    book = Book.new(title, author)
    @books.push(book)
    puts 'Book created successfully'
  end

  def list_all_books
    @books.each do |book|
      puts "Title: \"#{book.title}\", Author: #{book.author}"
    end
  end

  def list_all_people
    @people.each do |person|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "[#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      type = person.instance_of?(Student) ? 'Student' : 'Teacher'
      puts "#{index}) [#{type}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp.to_i
    print 'Date: '
    date = gets.chomp
    Rental.new(date, @books[book_index], @people[person_index])
    puts 'Rental created successfully'
  end

  def get_rental(id)
    person = @people.find { |person_id| person_id.id == id }
    puts 'Rentals:'
    person.rentals.each do |rental|
      puts "Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end

  def create_person_option
    print 'Do you want to create student (1) or a teacher (2)? [Input the number]: '
    person_code = gets.chomp.to_i
    create_person(person_code)
  end

  def create_book_option
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    create_book(title, author)
  end

  def rental_option
    print 'ID of person: '
    id = gets.chomp.to_i
    get_rental(id)
  end
end
