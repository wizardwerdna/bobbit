require_relative 'request'
require_relative 'response'

class Interactor
 
  def initialize request = {}
    @r = Request.new request 
  end

  def execute
    raise "abstract class instance should not be executed"
  end
  
private

  attr_reader :r

end
