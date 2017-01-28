SELECT chain
--, avg(rate) AS rates
 
FROM hotel JOIN booking ON (hotel.hotelname = booking.hotelname AND hotel.hotelcity = booking.hotelcity)


--WHERE avg(rate) = (SELECT min(avg(rate)) FROM booking)
GROUP BY chain
ORDER BY avg(rate) ASC
LIMIT 1






