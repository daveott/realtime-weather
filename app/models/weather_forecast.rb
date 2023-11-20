# frozen_string_literal: true

# A model that represents a weather forecast for a given location
class WeatherForecast < ApplicationRecord
  # A forecast for a particular location is cached
  # as a JSON string in Redis
  kredis_json :realtime_forecast
  kredis_json :extended_forecast

  geocoded_by :location

  after_validation :geocode

  validates :location, presence: { message: 'must be a valid city and state combination, or zipcode' }

  def current_forecast
    @current_forecast ||= TomorrowIo.new(to_coordinates.join(', '))
  end

  def current_extended_forecast
    @current_extended_forecast ||= TomorrowIo.new(to_coordinates.join(', '), extended_forecast: true)
  end

  def temperature(scale=:fahrenheit)
    return 0.0 unless realtime_forecast.value
    temp = JSON.parse(realtime_forecast.value).dig('data', 'values', 'temperature')
    return temp if scale == :celcius

    (temp * 9 / 5) + 32
  end

  def update_forecast!
    Rails.cache.fetch("weather_forecast:#{location}:realtime", expires_in: 30.minutes) do
      realtime_forecast.value = current_forecast.body if current_forecast.successful?
    end
  end

  def update_extended_forecast!
    Rails.cache.fetch("weather_forecast:#{location}:extended", expires_in: 30.minutes) do
      extended_forecast.value = current_extended_forecast.body if current_extended_forecast.successful?
    end
  end

  def daily_extended_forecast
    JSON.parse(extended_forecast.value).dig('timelines', 'daily')
  end
end
