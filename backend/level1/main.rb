require 'json'
require 'date'

filejson = File.read('data/input.json')
datajson = JSON.parse(filejson)
finalresult = { "rentals" => []}

datajson["rentals"].each {|rental|
	firstDate = Date.parse(rental["start_date"])
	lastDate = Date.parse(rental["end_date"])
	days = (lastDate - firstDate).to_i + 1

	cars = datajson["cars"].detect {|car| car["id"]	== rental["car_id"]}
	price = (days * cars["price_per_day"]) + (rental["distance"] * cars["price_per_km"])

	finalresult["rentals"] += [{
		"id" => rental["id"],
		"price" => price,
	}]
}

	File.write("data/output.json", JSON.pretty_generate(finalresult))