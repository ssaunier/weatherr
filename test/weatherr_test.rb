require "test_helper"

class WeatherrTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Weatherr::VERSION
  end

  def test_it_return_weather_data
    url = "https://api.openweathermap.org/data/2.5/weather"
    stub_request(:get, url)
      .with(query: { appid: 'API_KEY', q: 'Paris' })
      .to_return(
        status: 200,
        headers: { 'Content-Type': 'application/json' },
        body: File.open('test/support/paris.json').read)

    client = Weatherr::Client.new(api_key: 'API_KEY')
    data = client.current(city_name: 'Paris')
    assert_equal 7.9, data[:temperature]
    assert_equal "Clear", data[:comment]
  end
end
