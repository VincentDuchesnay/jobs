require 'json'
require 'date'

filejson = File.read('data/input.json')
datajson = JSON.parse(filejson)
finalresult = { "rentals" => []}

datajson["rentals"].each {|rental|
	firstDate = Date.parse(rental["start_date"])
	lastDate = Date.parse(rental["end_date"])
	reduc = 0
	days = (lastDate - firstDate).to_i + 1

	cars = datajson["cars"].detect {|car| car["id"]	== rental["car_id"]}
	price_per_day = cars["price_per_day"]

	if days > 1 then
		reduc = price_per_day * 0.1
	end

	if days > 4 then
		reduc = price_per_day * 0.3
	end

	if days > 10 then
		reduc = price_per_day * 0.5
	end

	price_per_day = (days * price_per_day) - reduc

	price = price_per_day + (rental["distance"] * cars["price_per_km"])



	finalresult["rentals"] += [{
		"id" => rental["id"],
		"price" => price,
	}]
}

File.write("data/output.json", JSON.pretty_generate(finalresult))