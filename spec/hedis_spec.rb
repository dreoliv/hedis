require 'hedis'

describe Hedis::Repository do
  after do
    Ohm.redis.call "FLUSHDB"
  end

  it "retrives records from database based on the ID" do
    user_id = subject[:users].insert({ name: "John", email: "john@example.com" })

    expect(subject[:users][user_id]).to eq({ "name" => "John", "email" => "john@example.com" })
  end

  it "stores hashes in redis and returns the ID" do
    user_id = subject[:users].insert({ name: "John", email: "john@example.com" })

    expect(Ohm.redis.call "HGETALL", "users:#{user_id}").to eq ["name", "John", "email", "john@example.com"]
  end
end
