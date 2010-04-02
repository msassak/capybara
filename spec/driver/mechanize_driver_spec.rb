require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe Capybara::Driver::Mechanize do
  before do
    @driver = Capybara::Driver::Mechanize.new(TestApp)
  end
  
  it_should_behave_like "driver"
  it_should_behave_like "driver with header support"
  
end
