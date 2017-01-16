//
//  LocationWeather.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import CoreLocation

struct Coord {
    var lat: Double
    var long: Double
}

struct LocationWeather {
    var coord: Coord?
    var city: String?
    var country: String?
    var isoCode: String?
}
