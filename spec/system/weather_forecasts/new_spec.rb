# frozen_string_literal: true

require 'rails_helper'

describe 'Weather forecast index', type: :system do
  context 'with a valid city and state' do
    it 'displays the weather forecast' do
      visit new_weather_forecast_path

      expect(page).to have_text('Weather Forecast')

      fill_in 'Location', with: 'Cupertino, CA'
      click_button 'Get Forecast'

      expect(page).to have_text('Cupertino, CA')
      expect(page).to have_text('Temperature')
      expect(page).to have_link('New Search')
    end
  end

  context 'with an invalid location' do
    it 'displays an error' do
      visit new_weather_forecast_path

      expect(page).to have_text('Weather Forecast')

      fill_in 'Location', with: 'asdf'
      click_button 'Get Forecast'

      expect(page).to have_text('Location must be a valid city and state combination, or zipcode')
    end

  end
end
