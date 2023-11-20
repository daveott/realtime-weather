# frozen_string_literal: true

require 'uri'
require 'net/http'

API_KEY = 'osJ5n2tnu3ntYIoWF6PMTTxPL8gDU8Xc'

# A class that handles retrieving weather forecasts from the Tomorrow.io API
class TomorrowIo
  attr_reader :location

  def initialize(location)
    @location = CGI.escape(location)
  end

  alias extended_forecast? extended_forecast

  def base_url
    'https://api.tomorrow.io/v4/weather'
  end

  def forecast_url
    "#{base_url}/forecast?location=#{location}&timesteps=1d&apikey=#{API_KEY}"
  end

  def realtime_url
    "#{base_url}/realtime?location=#{location}&apikey=#{API_KEY}"
  end

  def url
    @url ||= URI(extended_forecast? ? forecast_url : realtime_url)
  end

  def http
    Net::HTTP.new(url.host, url.port).tap do |net|
      net.use_ssl = true
    end
  end

  def request
    Net::HTTP::Get.new(url).tap do |r|
      r['accept'] = 'application/json'
    end
  end

  # memoize the response so that multiple requests are not made
  def response
    @response ||= http.request(request)
  end

  def body
    response.read_body
  end

  def successful?
    response.code == '200'
  end
end
