class AddLatLongToWeatherForecast < ActiveRecord::Migration[7.1]
  def change
    add_column :weather_forecasts, :latitude, :decimal, precision: 10, scale: 6
    add_column :weather_forecasts, :longitude, :decimal, precision: 10, scale: 6
  end
end
