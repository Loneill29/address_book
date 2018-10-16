require_relative 'entry'

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
