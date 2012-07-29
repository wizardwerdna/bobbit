class PagesController < ApplicationController

  def index
    @pages = ::Pages::All[].pages
  end

end
