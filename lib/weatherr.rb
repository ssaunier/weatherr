require "weatherr/version"
require "http"

module Weatherr
  class Client
    BASE_URL = "https://api.openweathermap.org/data/2.5"
    ABSOLUTE_ZERO = -273.15

    def initialize(opts = {})
      @api_key = opts[:api_key]
    end

    def current(opts = {})
      params = { q: opts[:city_name], appid: @api_key }
      url = "#{BASE_URL}/weather"
      response = HTTP.get(url, params: params).parse
      return {
        temperature: (response['main']['temp'] + ABSOLUTE_ZERO).round(1),
        comment: response['weather'][0]['main']
      }
    end
  end
end
