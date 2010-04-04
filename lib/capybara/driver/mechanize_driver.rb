require 'mechanize'

class Capybara::Driver::Mechanize < Capybara::Driver::Base
  attr_reader :app_host

  def initialize(app)
    @app = app
    @app_host = (ENV["CAPYBARA_APP_HOST"] || Capybara.app_host || "http://example.com")
    @agent = Mechanize.new
  end

  def visit(path)
    reset_cache
    @agent.get(app_host + path)
  end

  def response
    @agent.current_page
  end

  def find(selector)
    html.xpath(selector).map { |node| Capybara::Driver::RackTest::Node.new(self, node) }
  end

  def body
    @body ||= response.body
  end

  def html
    @html ||= Nokogiri::HTML(body)
  end

  def current_url
    response.uri.to_s
  end

  def response_headers
    response.header
  end

  private

  def reset_cache
    @body = @html = nil
  end
end
