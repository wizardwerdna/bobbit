require_relative '../../entities/entities'
require_relative '../../boundaries/interactor_interface'
require_relative '../../interactors/config_static_text'

describe ConfigStaticText do

  let(:request){OpenStruct.new name: 'name', locator: 'http://first.com/locator.html'}
  let(:subject){ConfigStaticText.new(request)}
  
  before :each do
    Repository.configure Static => MemoryRepos::StaticRepo.new
  end 
 
  it_should_behave_like "an interactor"

  it "should store the specification in the Static Repository" do
    ConfigStaticText.new(request).execute
    saved = Repository.for(Static).fetch_by_name(request.name)
    saved.name.should == request.name
    saved.locator.should == request.locator
  end

end
