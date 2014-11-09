require "hedis/version"
require "ohm"

module Hedis
  class Repository
    def initialize
      @schema = {}
    end

    def [](relation)
      @schema[relation] ||= Dataset.new(relation)
    end
  end

  class Dataset
    include Ohm

    def initialize(relation)
      @relation = relation
    end

    def [](id)
      Utils.dict(redis.call("HGETALL", key(id)))
    end

    def insert(data)
      script(LUA_SAVE, 0,
        { "name" => relation }.to_msgpack,
        data.to_msgpack,
        {}.to_msgpack,
        {}.to_msgpack
      )
    end

    private

    attr_reader :relation

    def key(id)
      Nido.new(relation)[id]
    end

    def redis
      Ohm.redis
    end

    def script(file, *args)
      cache = LUA_CACHE[redis.url]

      if cache.key?(file)
        sha = cache[file]
      else
        src = File.read(file)
        sha = redis.call("SCRIPT", "LOAD", src)

        cache[file] = sha
      end

      redis.call("EVALSHA", sha, *args)
    end
  end
end
