# frozen_string_literal: true

require 'rails_helper'

describe TomorrowIo, type: :model do
  describe '#url' do
    context 'without an extended forecast' do
      it 'returns the url' do
        tomorrow_io = TomorrowIo.new('Cupertino, CA')
        expect(tomorrow_io.url.path).to include('/v4/weather/realtime')
      end
    end

    context 'with an extended forecast' do
      it 'returns the url' do
        tomorrow_io = TomorrowIo.new('Cupertino, CA', extended_forecast: true)
        expect(tomorrow_io.url.path).to include('/v4/weather/forecast')
      end
    end
  end
end
