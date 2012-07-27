require_relative '../lib/interactor.rb'
module Pages

  class All < Interactor
    def execute
      Response.new pages: Repository.for(Page).all      
    end 
  end
  
  class Set < Interactor
    def execute
      Repository.for(Page).store Page.new(name: @r.name, locator: @r.locator)
    end
  end

  class Get < Interactor
    def execute
      Response.new page: Repository.for(Page).fetch(@r.name)
    end
  end

end

