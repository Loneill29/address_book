require_relative '../models/address_list'

class MenuController
  attr_reader :address_list

  def initialize
    @address_list = AddressList.new
  end

  def main_menu
    puts "\nMain Menu - #{address_list.entries.count} entries"
    puts "\n1 - View all entries"
    puts "2 - Create a new entry"
    puts "3 - Select an entry"
    puts "4 - Search for an entry"
    puts "5 - Import entries from a CSV"
    puts "6 - Delete all entries"
    puts "7 - Exit"
    print "\nEnter your selection: "

    selection = gets.to_i    #converts user input to integer

    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        add_entry
        main_menu
      when 3
        system "clear"
        select_entry
        main_menu
      when 4
        system "clear"
        search_entries
        main_menu
      when 5
        system "clear"
        read_csv
        main_menu
      when 6
        system "clear"
        @address_list.delete_all
        puts "All entries have been deleted"
        main_menu
      when 7
        puts "Goodbye!"
        exit(0)
      else
        system "clear"
        puts "Sorry, that is not a valid selection. Please try again"
        main_menu
      end
    end

  def view_all_entries
    address_list.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def add_entry
    system "clear"
    puts "New Entry"

    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone_number = gets.chomp
    print "Email address: "
    email = gets.chomp

    address_list.create_entry(name, phone_number, email)

    system "clear"
    puts "New entry saved"
  end

  def select_entry
    print "Entry number: "

    selection = gets.chomp.to_i

    if selection < @address_list.entries.count    #verify that the entry exists
      puts @address_list.entries[selection]
      puts "Press enter to return to the main menu"
      gets.chomp
      system "clear"
    else
      puts "#{selection} is not a valid selection. Please try again"
      select_entry
    end
  end

  def search_entries
    print "Search for entry by name: "
    name = gets.chomp

    match = address_list.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def search_submenu(entry)
    puts "\nd - delete entry"
    puts "e - edit entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid selection. Please try again"
        puts entry.to_s
        search_submenu(entry)
      end
    end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin    #if an exception is thrown, error message is displayed
      entry_count = address_list.import_from_csv(file_name).entry_count
      system "clear"
      puts "#{entry_count} new entries imported from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file. Please try again"
      read_csv
    end
  end

  def entry_submenu(entry)
    puts "\nn - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    selection = gets.chomp

    case selection
      when "n"
      when "d"
        delete_entry(entry)
      when "e"
        edit_entry(entry)
        entry_submenu(entry)
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid selection. Please try again"
        entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_list.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email address: "
    email = gets.chomp
    #makes sure input is valid
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"

    puts "Updated entry: "
    puts entry
  end
end
