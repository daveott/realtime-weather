# frozen_string_literal: true

require 'rails_helper'

describe 'Weather forecast index', type: :system do
  context 'with a valid city and state' do
    it 'displays the weather forecast' do
      visit new_weather_forecasts_path

      expect(page).to have_text('Weather Forecast')

      fill_in 'Location', with: 'Cupertino, CA'
      click 'Get Forecast'

      expect(page).to have_text('Cupertino, CA')
    end
  end
end
