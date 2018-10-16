require_relative '../models/address_list'

RSpec.describe AddressList do

  describe "attributes" do
    it "responds to entries" do
      list = AddressList.new
      expect(list).to respond_to(:entries)
    end

    it "creates an entries array on initialization" do
      list = AddressList.new
      expect(list.entries).to be_an(Array)
    end

    it "initializes entries array as empty" do
      list = AddressList.new
      expect(list.entries.size).to eq(0)
    end
  end

  describe "#create_entry" do
    it "creates one new entry" do
      list = AddressList.new
      list.create_entry('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com')

      expect(list.entries.size).to eq(1)
    end

    it "adds the right information to the entry" do
      list = AddressList.new
      list.create_entry('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com')
      new_entry = list.entries[0]

      expect(new_entry.name).to eq('Linda ONeill')
      expect(new_entry.phone_number).to eq('708-334-1607')
      expect(new_entry.email).to eq('oneill.linda@gmail.com')
    end
  end

  describe "#delete_entry" do
    it "deletes an entry using the name, phone number, and email address" do
      list = AddressList.new
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
end
