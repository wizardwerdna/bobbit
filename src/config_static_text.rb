class ConfigStaticText
  def initialize request
    @name = request.name
    @locator = request.locator 
  end
  def execute
    Repository.for(Static).store Static.new(name: @name, locator: @locator)
  end 
end
