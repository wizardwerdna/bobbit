class Repository

  class NoRepository; end

  class NoRecord
    def self.clone; self; end
  end

  class << self
    def configure options
      @hash ||= {}
      @hash.merge! options
    end

    def for repo
      @hash.fetch(repo, NoRepository)
    end

    def reset!
      @hash = {}
    end
  end
end
