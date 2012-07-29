require_relative '../repositories/memory_repos'

def configure_memory_repository
  Repository.configure ({
    Page => MemoryRepos::PageRepo.new
  })
end

def seed_repository_for_page_entities
  [
    Page.new(name: 'google', locator: 'http://www.google.com'),
    Page.new(name: 'cnn', locator: 'http://www.cnn.com'),
    Page.new(name: 'apple', locator: 'http://www.apple.com')
  ].each{|each| Repository.for(Page).store each}
end

configure_memory_repository
seed_repository_for_page_entities

