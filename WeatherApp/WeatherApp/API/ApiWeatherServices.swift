//
//  ApiWeatherServices.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import Gloss

protocol ApiWeatherServicesProtocol {
    weak var apiWeatherServices: WeatherManagerProtocol? { get set }
    func getWeatherReport(_ url: URL)
    func getDailyWeatherReport(_ url: URL)
    func getCurrentReport(_ url: URL)
}

struct ApiWeatherServices: ApiWeatherServicesProtocol {
    static var config = URLSessionConfiguration.default
    var session: URLSession = URLSession(configuration: config)
    weak internal var apiWeatherServices: WeatherManagerProtocol?

    func getWeatherReport(_ url: URL) {
        let sessionTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print("\(json)")
                let forecast = HourDetailForecast(json: json as! JSON)
                self.apiWeatherServices?.didGetHourlyForecastInDetail(forecast: forecast!)
            } catch {
                 print("error: \(error)")
            }
        }) 
        sessionTask.resume()
    }

    func getDailyWeatherReport(_ url: URL) {
        let sessionTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                 print("\(json)")
                let daily = DailyForecast(json: json as! JSON)
                    self.apiWeatherServices?.didGetForecastForTheWeek((daily?.detail)!)
            } catch {
                print("error: \(error)")
            }
        })
        sessionTask.resume()
    }

    func getCurrentReport(_ url: URL) {
        let sessionTask = session.dataTask(with: url, completionHandler: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                let forecast = Forecast(json: json as! JSON)
                self.apiWeatherServices?.didGetCurrentReport(forecast: forecast!)
                print("\(json)")
            } catch {
                print("error: \(error)")
            }
        })
        sessionTask.resume()
    }
}
