//
//  Forecast.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import Gloss

struct DailyForecast: Decodable {
    let detail: [DailyForecastDetail]
    let city: City
    public init?(json: JSON) {
        self.detail = ("list" <~~ json)!
        self.city = ("city" <~~ json)!
    }
}
struct DailyForecastDetail: Decodable {
    let temp: Temperature
    let date: TimeInterval
    private let descriptions: [Descriptions]
    let iconID: Int
    public init?(json: JSON) {
        self.temp = ("temp" <~~ json)!
        self.date = ("dt" <~~ json)!
        self.descriptions = ("weather" <~~ json)!
        self.iconID = self.descriptions[0].description[0].iconID

    }
}
struct Temperature: Decodable {
    let max: Int
    let min: Int
    public init?(json: JSON) {
        self.max = ("max" <~~ json)!
        self.min = ("min" <~~ json)!
    }
}
struct City: Decodable {
    let name: String
    let coutryCode: String
    init?(json: JSON) {
        self.name = ("name" <~~ json)!
        self.coutryCode = ("country" <~~ json)!
    }
}
struct Descriptions: Decodable {
    let description: [IconDescription]
    init?(json: JSON) {
        self.description = [IconDescription].from(jsonArray: [json])!
    }
}
struct IconDescription: Decodable {
    let iconID: Int
    let detailedDescription: String
    init?(json: JSON) {
        self.iconID = ("id" <~~ json)!
        self.detailedDescription = ("description" <~~ json)!
    }
}
