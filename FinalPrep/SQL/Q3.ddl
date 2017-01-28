SELECT name
FROM traveler JOIN booking ON (traveler.travelerid = booking.travelerid)
		JOIN hotel ON (booking.hotelname = hotel.hotelname AND booking.hotelcity = hotel.hotelcity)

WHERE rate = minrate
