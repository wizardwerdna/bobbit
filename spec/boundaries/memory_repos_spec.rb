require_relative '../../entities/entities'
require_relative '../../boundaries/memory_repos'
require_relative '../../boundaries/indexed_repository_interface.rb'
describe MemoryRepos do

  context MemoryRepos::IndexedRepo do
    let(:repo) {MemoryRepos::IndexedRepo.new}
    let(:data) {OpenStruct.new(id: nil)}

    it_should_behave_like "an indexed repository"

    it "should default to indexing on :id" do
      repo.fetch(1).should == repo.fetch(1,:id)
    end
  end

  context MemoryRepos::StaticRepo do
    let(:repo) {MemoryRepos::StaticRepo.new}
    let(:data) {Static.new(name: 1)}

    it_should_behave_like "an indexed repository"

    it "should find by name" do
      repo.store data 
      repo.fetch_by_name(1).should == data
    end

    it "should default to find_by_emp_id" do
      repo.fetch_by_name(1).should == repo.fetch(1)
    end
  end

end
