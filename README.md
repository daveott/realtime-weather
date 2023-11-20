# README

This application consists of a simple location search form that accepts a valid location (city/state combination or zipcode) and returns a realtime forecast, cached in an interval of 30 minutes. If no valid location is entered, an error message is displayed.

A location is persisted in the database and a realtime forecast is stored via kredis. That forecast is refreshed when a new request for that location is made, given the cache has expired.

I have chosen to use the tomorrow.io API to retrieve weather forecasts for a location. The interaction with that API is encapsulated in the TomorrowIo model for simplicity. In a real world scenario, I would move configuration details for an external API to another location, abstract the HTTP connection bits, and generalize the interfaces so that other APIs could be easily swapped out for Tomorrow's.
