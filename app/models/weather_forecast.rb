# frozen_string_literal: true

# A model that represents a weather forecast for a given location
class WeatherForecast < ApplicationRecord
  # A forecast for a particular location is cached
  # as a JSON string in Redis
  kredis_json :realtime_forecast
  kredis_json :extended_forecast

  geocoded_by :location

  after_validation :geocode

  def current_forecast
    @current_forecast ||= TomorrowIo.new(to_coordinates.join(', '))
  end

  def temperature(scale=:fahrenheit)
    temp = JSON.parse(realtime_forecast.value).dig('data', 'values', 'temperature')
    return temp if scale == :celcius

    (temp * 9 / 5) + 32
  end

  def update_forecast!
    Rails.cache.fetch(location, expires_in: 30.minutes) do
      realtime_forecast.value = current_forecast.body if current_forecast.successful?
    end
  end
end
