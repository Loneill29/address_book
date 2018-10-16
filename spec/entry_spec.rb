require_relative '../models/entry'

RSpec.describe Entry do

  describe "entry attributes" do
    let (:entry) { Entry.new('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com') }

    it "responds to name" do
      expect(entry).to respond_to(:name)
    end

    it "reports its name" do
      expect(entry.name).to eq('Linda ONeill')
    end

    it "responds to phone number" do
      expect(entry).to respond_to(:phone_number)
    end

    it "reports its phone number" do
      expect(entry.phone_number).to eq('708-334-1607')
    end

    it "responds to email" do
      expect(entry).to respond_to(:email)
    end

    it "reports its email address" do
      expect(entry.email).to eq('oneill.linda@gmail.com')
    end
  end

  describe "#to_s" do
    let (:entry) { Entry.new('Linda ONeill', '708-334-1607', 'oneill.linda@gmail.com') }

    it "converts an entry to a string" do
      string = "Name: Linda ONeill\nPhone Number: 708-334-1607\nEmail Address: oneill.linda@gmail.com"
      expect(entry.to_s).to eq(string)
    end
  end
end
