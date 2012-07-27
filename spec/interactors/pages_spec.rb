require_relative '../../boundaries/interactor_interface'
require_relative '../../boundaries/repository'
require_relative '../../interactors/pages'

describe Page do

  let(:request){Request.new name: 'name', locator: 'http://first.com/locator.html'}
  let(:update_request){Request.new name: 'name', locator: 'http:/update.com/locator.html'}

  before :each do
    Repository.configure Page => MemoryRepos::PageRepo.new
  end 

  describe Pages::Set do

    let(:subject){Pages::Set.new(request)}

    it_should_behave_like "an interactor"

    it "should store an unsaved page specification in the Page Repository" do
      subject.execute
      response = Repository.for(Page).fetch_by_name(request.name)
      response.should == request
    end

    it "should update a saved page specification in the Page Repository" do
      Repository.for(Page).store Page.new(name: request.name, locator: request.locator)
      Pages::Set.new(update_request).execute
      saved = Repository.for(Page).fetch request.name
      saved.locator.should == update_request.locator
    end

  end

  describe Pages::All do
    let(:subject){Pages::All.new}
    let(:pages) { (1..10).map{|i| Page.new(name: i.to_s, locator: i.to_s)} }
    
    it_should_behave_like "an interactor"
    
    it "should answer an array of pages" do
      pages.each{|p| Repository.for(Page).store p}
      response = subject.execute
      response.pages.should == pages
    end
  end

  describe Pages::Get do
    let(:get_request){OpenStruct.new name: 'name'}
    let(:subject){Pages::Get.new(get_request)}

    it_should_behave_like "an interactor"

    it "should recover a saved page specification in the Page Repository" do
      Repository.for(Page).store request
      subject.execute.page.locator.should == request.locator
    end

    it "should answer NoRecord for an unsaved specification" do
      subject.execute
      subject.execute.page.should == Repository::NoRecord
    end
  end

end
