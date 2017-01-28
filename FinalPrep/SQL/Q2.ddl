SELECT hotelcity
FROM hotel
WHERE maxrate = (SELECT max(maxrate) FROM hotel)
