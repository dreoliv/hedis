require 'hedis'
require 'pry'

class User < Ohm::Model
  attribute :name
  attribute :email
end

describe Hedis::Repository do
  it "retrives records from database based on the ID" do
    user = User.create(name: "John", email: "john@example.com")

    expect(subject["User"][user.id]).to eq({ "name" => "John", "email" => "john@example.com" })
  end

  it "stores hashes in redis and returns the ID" do
    user_id = subject[:users].insert({ name: "John", email: "john@example.com" })

    expect(subject["User"][user_id]).to eq({ "name" => "John", "email" => "john@example.com" })
  end
end
