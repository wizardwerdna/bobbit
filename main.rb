require_relative 'application'
require_relative 'repositories/memory_repos'
module Bobbit
  class Main
    def initialize
      link_to_inmemory_repository
      seed_repository
    end
    def call env
      [200, {"content-type" => 'text/html'}, [response_html]]
    end

    def link_to_inmemory_repository
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

    def response_html
      <<-HTML
        <HTML>
        <HEAD>
          <TITLE>List of Shortcuts</TITLE>
        </HEAD>
        <BODY>
          <H1>List of Shortcuts</H1>
          <TABLE style="outline: 2pt solid black;">
          <TR><TH>Shortcut</TH><TH>Locator</TH></TR>
          #{rows_html}
          </TABLE>
        </BODY>
        </HTML>
      HTML
    end

    def rows_html
      Pages::All.new.execute.pages.map do |page|
        "<TR><TD><A href=\"#{page.locator}\">#{page.name}</A></TD><TD>#{page.locator}</TD></TR>"
      end.join("\n")
    end

  end

end
