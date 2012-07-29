require 'sinatra'
require_relative '../application'
require_relative 'initialize_and_seed_memory_repo'

module Bobbit

  class Main < Sinatra::Base

    # List all Shortcuts
    get '/' do
      erb :index, locals: {pages: Pages::All[].pages}
    end

    # Follow Shortcut
    get '/:name' do |name|
      response = Pages::Get[name: name]
      if response.page == Repository::NoRecord
        [404, {"content-type" => "text/html"}, "404 Shortcut Not Found"]
      else
        redirect response.page.locator
      end
    end

    # Set Shortcut (Sorry to HTTP Specs)
    get %r{/set/([^/]*)/(.*)} do
      name, locator = params[:captures][0..1]
      Pages::Set[name: name, locator: locator]
      redirect to('/')
    end

  end

end
