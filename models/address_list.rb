require_relative 'entry'
require "csv"

class AddressList
  attr_reader :entries

  def initialize
    @entries = []
  end

  def create_entry(name, phone_number, email)
    index = 0

    entries.each do |entry|
      if name < entry.name    #if name proceeds the current entry alphabetically, exit the loop and insert
        break
      end
      index += 1 #otherwise check it against the next name
    end

    entries.insert(index, Entry.new(name, phone_number, email))
  end

  def import_from_csv(file_name)
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)    #parse file into a CSV::Table object
    #iterate over table and create a hash for each row
    csv.each do |row|
      row_hash = row.to_hash
      #convert each row_hash to an entry and add to address_list
      create_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end

  def delete_entry(name, phone_number, email)
    selected_entry = nil    #create a variable for the entry to be deleted

    @entries.each do |entry|
      if name == entry.name && phone_number == entry.phone_number && email == entry.email
        selected_entry = entry
      end
    end
    @entries.delete(selected_entry)
  end
end
