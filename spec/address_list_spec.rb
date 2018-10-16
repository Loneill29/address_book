require_relative '../models/address_list'

RSpec.describe AddressList do
  let(:list) { AddressList.new }

  #used in import_from_csv tests to verify entries
  def check_entry(entry, expected_name, expected_phone, expected_email)
    expect(entry.name).to eq(expected_name)
    expect(entry.phone_number).to eq(expected_phone)
    expect(entry.email).to eq(expected_email)
  end

  describe "attributes" do
    it "responds to entries" do
      expect(list).to respond_to(:entries)
    end

    it "creates an entries array on initialization" do
      expect(list.entries).to be_an(Array)
    end

    it "initializes entries array as empty" do
      expect(list.entries.size).to eq(0)
    end
  end

  describe "#create_entry" do
    it "creates one new entry" do
      list.create_entry('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com')

      expect(list.entries.size).to eq(1)
    end

    it "adds the right information to the entry" do
      list.create_entry('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com')
      new_entry = list.entries[0]

      expect(new_entry.name).to eq('Linda ONeill')
      expect(new_entry.phone_number).to eq('708-334-1607')
      expect(new_entry.email).to eq('oneill.linda@gmail.com')
    end
  end

  describe "#delete_entry" do
    it "deletes an entry using the name, phone number, and email address" do
      #create two new entries
      list.create_entry('New Name', '123-456-789', 'email@gmail.com')

      name = 'Linda ONeill'
      phone_number = '708-334-1607'
      email = 'oneill.linda@gmail.com'
      list.create_entry(name, phone_number, email)

      expect(list.entries.size).to eq(2)
      #delete the second entry - verify that only one entry was removed
      list.delete_entry(name, phone_number, email)
      expect(list.entries.size).to eq(1)

      expect(list.entries.first.name).to eq('New Name')
    end
  end

  describe "#import_from_csv" do
    it "imports the correct number of entries" do
      list.import_from_csv("entries.csv")
      list_size = list.entries.size

      expect(list_size).to eq(5)    #assuming list has 5 initial entries
    end

    it "imports the first entry" do
      list.import_from_csv("entries.csv")
      entry_one = list.entries[0]

      check_entry(entry_one, "Bill", "333-333-3333", "bill@email.com")
    end

    it "imports the second entry" do
      list.import_from_csv("entries.csv")
      entry_two = list.entries[1]

      check_entry(entry_two, "Bob", "111-111-1111", "bob@email.com")
    end

    it "imports the third entry" do
      list.import_from_csv("entries.csv")
      entry_three = list.entries[2]

      check_entry(entry_three, "Brian", "222-222-2222", "brian@email.com")
    end

    it "imports the fourth entry" do
      list.import_from_csv("entries.csv")
      entry_four = list.entries[3]

      check_entry(entry_four, "John", "444-444-4444", "john@email.com")
    end

    it "imports the fifth entry" do
      list.import_from_csv("entries.csv")
      entry_five = list.entries[4]

      check_entry(entry_five, "Sara", "555-555-5555", "sara@email.com")
    end
  end

  describe "imports from a second csv file" do
    it "imports the correct number of entries" do
      list.import_from_csv("entries_2.csv")
      list_size = list.entries.size
      expect(list_size).to eq(3)
    end

    it "imports the first entry" do
      list.import_from_csv("entries_2.csv")
      entry_one = list.entries[0]

      check_entry(entry_one, "Erin", "333-333-3333", "erin@email.com")
    end

    it "imports the second entry" do
      list.import_from_csv("entries_2.csv")
      entry_two = list.entries[1]

      check_entry(entry_two, "Jay", "111-111-1111", "jay@email.com")
    end

    it "imports the third entry" do
      list.import_from_csv("entries_2.csv")
      entry_three = list.entries[2]

      check_entry(entry_three, "Sam", "222-222-2222", "sam@email.com")
    end
  end
end
