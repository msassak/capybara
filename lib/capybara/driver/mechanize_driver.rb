require 'mechanize'

class Capybara::Driver::Mechanize < Capybara::Driver::Base

  attr_reader :app_host

  def initialize(app)
    @app = app
    @app_host = (ENV["CAPYBARA_APP_HOST"] || Capybara.app_host || "http://example.com")
    @agent = Mechanize.new
  end

  def visit(path)
    @agent.get(app_host + path)
  end

  def response
    @agent.current_page
  end

  def body
    response.body
  end

  def current_url
    response.uri.to_s
  end

  def response_headers
    response.header
  end
end
