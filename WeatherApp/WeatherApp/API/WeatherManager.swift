//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

protocol WeatherManagerProtocol: class {
    weak var weatherDetailViewProtocol: WeatherDetailViewProtocol? { get set }
    var servicesManager : ApiWeatherServicesProtocol! { get set }

    func getHourlyForecastInDetail(_ location: LocationWeather)
    func didGetHourlyForecastInDetail(forecast: HourDetailForecast)

    func getForecastForTheWeek(_ location: LocationWeather)
    func didGetForecastForTheWeek(_ week: [DailyForecastDetail])

    func getCurrentReport( _ location: LocationWeather)
    func didGetCurrentReport(forecast: Forecast)
}

class WeatherManager: WeatherManagerProtocol{
    var servicesManager: ApiWeatherServicesProtocol! = ApiWeatherServices()
    var weatherDetailViewProtocol: WeatherDetailViewProtocol?

    let reportInterval = 3
    init() {
        servicesManager.apiWeatherServices = self
    }

    func getHourlyForecastInDetail(_ location: LocationWeather) {
        let url = APIWeatherRequests.forecastRequestForCity(location.city!, countryCode: location.isoCode!)
        servicesManager.getWeatherReport(url)
    }

    func didGetHourlyForecastInDetail(forecast: HourDetailForecast) {
        DispatchQueue.main.async {
            let selectedDate = self.weatherDetailViewProtocol?.selectedDate()
            let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate!)
            let calendar = NSCalendar.autoupdatingCurrent
            let filteredForecast = forecast.days.filter({
                (calendar.isDate($0.date, inSameDayAs: selectedDate!) || calendar.isDate($0.date, inSameDayAs: tomorrow!))
            })

            let only24HoursReport = Array(filteredForecast[0 ... (24/self.reportInterval)-1])
            self.weatherDetailViewProtocol?.hourlyDataModel(model: only24HoursReport)
        }
    }

    func getForecastForTheWeek(_ location: LocationWeather){
        let urldWeek = APIWeatherRequests.dailyForecastRequestForCity(location.city!)
        servicesManager.getDailyWeatherReport(urldWeek)
    }

    func didGetForecastForTheWeek(_ week: [DailyForecastDetail]) {
        DispatchQueue.main.async {
             let forecast5Days = Array(week[1...week.count-1]) // take out first index
            self.weatherDetailViewProtocol?.dataModel(model: forecast5Days)
        }
    }

    func getCurrentReport( _ location: LocationWeather) {
        let url = APIWeatherRequests.currentReportRequestForCity(location.city!)
        servicesManager.getCurrentReport(url)
    }

    func didGetCurrentReport(forecast: Forecast) {
        DispatchQueue.main.async {
            self.weatherDetailViewProtocol?.showTemp(forecast: forecast)
        }
    }

}
