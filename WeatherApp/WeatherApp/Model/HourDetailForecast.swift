//
//  HourDetailForecast.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

import Foundation
import Gloss


struct HourDetailForecast: Decodable {
    let days: [Forecast]
    public init?(json: JSON) {
        self.days = ("list" <~~ json)!
    }
}

struct Forecast: Decodable {
    let detail: Detail
    let date: Date
    private let descriptions: [Descriptions]
    let iconID: Int
    let detailedDescription: String
    public init?(json: JSON) {
        self.detail = ("main" <~~ json)!
        let dateSeconds: Double = ("dt" <~~ json)!
        self.date = Date(timeIntervalSince1970: dateSeconds)
        self.descriptions = ("weather" <~~ json)!
        self.iconID = self.descriptions[0].description[0].iconID
        self.detailedDescription = self.descriptions[0].description[0].detailedDescription
    }
}

struct Detail: Decodable {
    let tempMax: Int
    let tempMin: Int
    let temp: Int
    public init?(json: JSON) {
        self.tempMax = ("temp_max" <~~ json)!
        self.tempMin =  ("temp_min" <~~ json)!
        self.temp =  ("temp" <~~ json)!
    }
}
