//
//  APIWeatherRequests.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

class APIWeatherRequests: NSObject {
    static let WeatherAPIBAseURL = "http://api.openweathermap.org/data/2.5"
    static let APIKEY = "&APPID=1a308039270e6264de807ee8be611252"

    static func forecastRequestForCity(_ city: String, countryCode: String) -> URL {
        let cityFormated = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let params = "/forecast?q=" + cityFormated! + "," + countryCode + "&units=metric&mode=json"
        let str = WeatherAPIBAseURL + params + APIKEY
        let url = URL(string: str)
        return url!
    }

    static func dailyForecastRequestForCity(_ city: String) -> URL {
        let cityFormated = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
         let params = "/forecast/daily?q=" + cityFormated! + "&units=metric&cnt=6"
        let str = WeatherAPIBAseURL + params + APIKEY
        let url = URL(string: str)
        return url!
    }

    static func currentReportRequestForCity(_ city: String) -> URL {
        let cityFormated = city.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let params = "/weather?q=" + cityFormated! + "&units=metric&cnt=6"
        let str = WeatherAPIBAseURL + params + APIKEY
        let url = URL(string: str)
        return url!
    }
}
