//
//  WeatherManagerTest.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import XCTest
@testable import WeatherApp


var didGetWeatherReport = false
var didGetDailyWeatherReport = false
var didGetCurrentReport = false

class WeatherManagerTest: XCTestCase {

    class TestApiWeatherServicesProtocol: ApiWeatherServicesProtocol {

        var expectation: XCTestExpectation?
        weak var apiWeatherServices: WeatherManagerProtocol?
        func getWeatherReport(_ url: URL) {
            didGetWeatherReport = true
        }

        func getDailyWeatherReport(_ url: URL) {
            didGetDailyWeatherReport = true
        }
        func getCurrentReport(_ url: URL){
            didGetCurrentReport = true
        }
    }

    var sut : WeatherManagerProtocol!
    var mockLocation = LocationWeather()
    override func setUp() {
        mockLocation.city = "Dublin"
        mockLocation.country = "Ireland"
        mockLocation.isoCode = "IE"
        mockLocation.coord?.lat =  53.3498
        mockLocation.coord?.long = 6.2603

        super.setUp()
        sut = WeatherManager()
        sut.servicesManager = TestApiWeatherServicesProtocol()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testGetForecast() {
        sut.getHourlyForecastInDetail(mockLocation)
        XCTAssertTrue(didGetWeatherReport)
    }

    func testDailyReport() {
        sut.getForecastForTheWeek(mockLocation)
        XCTAssertTrue(didGetDailyWeatherReport)
    }

    func testCurrentReport() {
        sut.getCurrentReport(mockLocation)
        XCTAssertTrue(didGetCurrentReport)
        
    }
}
