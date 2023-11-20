# frozen_string_literal: true

# A controller that handles retrieving weather forecasts
class WeatherForecastsController < ApplicationController
  def create
    @weather_forecast = WeatherForecast.find_or_initialize_by(
      location: location.city_state
    )

    if @weather_forecast.save
      @weather_forecast.update_forecast!
      redirect_to @weather_forecast
    else
      render :new, status: 422
    end
  end

  def show
    @weather_forecast = WeatherForecast.find(params[:id])
    @weather_forecast.update_forecast!
  end

  def extended
    @weather_forecast = WeatherForecast.find(params[:id])
    @weather_forecast.update_extended_forecast!
  end

  private

  def location
    @location ||= Location.new(location: weather_forecast_params[:location])
  end

  def weather_forecast_params
    params.require(:weather_forecast).permit(:location)
  end
end
