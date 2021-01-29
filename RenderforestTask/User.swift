//
//  User.swift
//  RenderforestTask
//
//  Created by Alvard Dallakyan on 29.01.21.
//

import Foundation

class User {
	var name = Name()
	var gender = String()
	var phone = String()
	var location = Location()
	var picture = Picture()
}

class Name {
	var title = String()
	var first = String()
	var last = String()
}

class Picture {
	var large = URL.self
	var medium = URL.self
	var thumbnail = URL.self
}

class Location {
	var street = Street()
	var city = String()
	var state = String()
	var country = String()
	var postcode = Int()
	var coordinates = Coordinates()
	var timezone = Timezone()
}

class Street {
	var number = Int()
	var name = String()
}

class Coordinates {
	var latitude = String()
	var longitude = String()
}

class Timezone {
	var offset = String()
	var description = String()
}
