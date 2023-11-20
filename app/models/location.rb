# frozen_string_literal: true

# A model that represents a location
class Location
  include ActiveModel::API

  attr_accessor :location

  validates :location, presence: true
  validate :zip_code_or_state?

  def zip_code?
    location.to_s.match?(/\A\d{5}\z/)
  end

  def city_state?
    location.to_s.match?(/\A[A-Za-z\s]+,\s[A-Za-z]{2}\z/)
  end

  def city_state
    return location if city_state?
    return unless zip_code?

    ZipCodes.identify(location).values_at(:city, :state_code).join(', ')
  end

  def zip_code
    return location if zip_code?
  end

  def zip_code_or_state?
    return false unless location

    zip_code? || city_state?
  end
end
