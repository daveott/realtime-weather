# frozen_string_literal: true

require 'rails_helper'

describe Location, type: :model do
  describe '#valid?' do
    it { should validate_presence_of(:location) }

    context 'with a valid zip code' do
      it 'returns true' do
        location = Location.new(location: '95014')
        expect(location.valid?).to eq(true)
      end
    end

    context 'with a valid city and state' do
      it 'returns true' do
        location = Location.new(location: 'Cupertino, CA')
        expect(location.valid?).to eq(true)
      end
    end
  end

  describe '#zip_code?' do
    context 'with a valid zip code' do
      it 'returns true' do
        location = Location.new(location: '12345')
        expect(location.zip_code?).to eq(true)
      end
    end

    context 'without a valid zip code' do
      it 'returns false' do
        location = Location.new(location: 'Cupertino, CA')
        expect(location.zip_code?).to eq(false)
      end
    end
  end

  describe '#city_state?' do
    context 'with a valid city and state' do
      it 'returns true' do
        location = Location.new(location: 'Cupertino, CA')
        expect(location.city_state?).to eq(true)
      end
    end

    context 'without a valid city and state' do
      it 'returns false' do
        location = Location.new(location: '12345')
        expect(location.city_state?).to eq(false)
      end
    end
  end

  describe '#city_state' do
    context 'with a valid zip code' do
      it 'returns the city and state' do
        location = Location.new(location: '95014')
        expect(location.city_state).to eq('Cupertino, CA')
      end
    end

    context 'without a valid zip code' do
      it 'returns nil' do
        location = Location.new(location: '123')
        expect(location.city_state).to eq(nil)
      end
    end
  end

  describe '#zip_code' do
    context 'with a valid city and state' do
      it 'returns the zip code' do
        location = Location.new(location: '95014')
        expect(location.zip_code).to eq('95014')
      end
    end

    context 'without a valid zip code' do
      it 'returns nil' do
        location = Location.new(location: 'Cupertino, CA')
        expect(location.zip_code).to eq(nil)
      end
    end
  end
end
