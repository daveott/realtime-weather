class CreateWeatherForecasts < ActiveRecord::Migration[7.1]
  def change
    create_table :weather_forecasts do |t|
      t.string :location, null: false

      t.timestamps
    end
  end
end
