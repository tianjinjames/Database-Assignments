SELECT hotel.hotelcity, chain, count(*) AS counts
FROM hotel JOIN booking ON (hotel.hotelname = booking.hotelname AND hotel.hotelcity = booking.hotelcity)


WHERE arrdate LIKE '2012-08-__'

GROUP BY hotel.hotelcity, hotel.chain

HAVING count(*) > 1


ORDER BY count(*) DESC
