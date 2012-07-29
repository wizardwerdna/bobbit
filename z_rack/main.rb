require_relative '../application'
require_relative '../repositories/memory_repos'

LIST_ROUTE     = %r{^/$}
SHORTCUT_ROUTE = %r{^/([^/]+)$}
SETTER_ROUTE   = %r{^/set/([^/]+)/(.+)$}

module Bobbit
  class Main

    attr_accessor :env

    def initialize
      initialize_inmemory_repository
      seed_repository
    end

    def call env
      self.env = env
      response_for_rack_request
    end

  private

    def response_for_rack_request
      
      case env["REQUEST_PATH"]

      when LIST_ROUTE     then response_for_list_request
      when SHORTCUT_ROUTE then response_for_redirect_for $1 
      when SETTER_ROUTE   then response_for_set_or_reset $1, $2 

      else response_404 

      end 

    end

    def response_for_list_request

      pages = Pages::All[].pages
      [200, text_content_header, [response_html(pages)]]

    end

    def response_for_redirect_for shortcut
      response = Pages::Get[name: shortcut]
      if response.page == Repository::NoRecord
        response_404
      else
        redirect_to response.page.locator
      end

    end

    def response_for_set_or_reset shortcut, locator
      Pages::Set[name: shortcut, locator: locator]
      [200, text_content_header, [response_html(Pages::All[].pages)]] 
    end

    def initialize_inmemory_repository
      Repository.configure ({
        Page => MemoryRepos::PageRepo.new
      })
    end

    def seed_repository
      [
        Page.new(name: 'google', locator: 'http://www.google.com'),
        Page.new(name: 'cnn', locator: 'http://www.cnn.com'),
        Page.new(name: 'apple', locator: 'http://www.apple.com')
      ].each{|each| Repository.for(Page).store each}
    end

    def text_content_header
      { "Content-Type" => "text/html" }
    end

    
    def redirect_to location
      [301, {"Location" => location, "Content-Type" => "text/html"}, []]
    end

    def response_404
      [404, text_content_header, ["404 Page Not Found -- #{env['REQUEST_PATH']}"]]
    end

    def response_html pages
      <<-HTML
        <HTML>
        <HEAD>
          <TITLE>List of Shortcuts</TITLE>
        </HEAD>
        <BODY>
          <H1>List of Shortcuts</H1>
          <TABLE style="outline: 2pt solid black;">
          <TR><TH>Shortcut</TH><TH>Locator</TH></TR>
          #{rows_html pages}
          </TABLE>
        </BODY>
        </HTML>
      HTML
    end

    def rows_html pages
      pages.map do |page|
        "<TR><TD><A href=\"#{page.locator}\">#{page.name}</A></TD><TD>#{page.locator}</TD></TR>"
      end.join("\n")
    end

  end

end
