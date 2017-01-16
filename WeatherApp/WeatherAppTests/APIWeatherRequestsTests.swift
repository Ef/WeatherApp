//
//  APIWeatherRequestsTests.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation


import XCTest
@testable import WeatherApp


class APIWeatherRequestsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testURLsForCity() {
        let urlExpected = "http://api.openweathermap.org/data/2.5/forecast?q=Dublin,IE&units=metric&mode=json&APPID=1a308039270e6264de807ee8be611252"
        let url = APIWeatherRequests.forecastRequestForCity("Dublin", countryCode: "IE")
        XCTAssertEqual(urlExpected, String(describing: url))

    }

    func testURLsForDailyForecast() {
        let urlExpected = "http://api.openweathermap.org/data/2.5/forecast/daily?q=Dublin&units=metric&cnt=6&APPID=1a308039270e6264de807ee8be611252"
        let url = APIWeatherRequests.dailyForecastRequestForCity("Dublin")
        XCTAssertEqual(urlExpected, String(describing: url))

    }

    func testCurrentReport() {
        let urlExpected = "http://api.openweathermap.org/data/2.5/weather?q=Dublin&units=metric&cnt=6&APPID=1a308039270e6264de807ee8be611252"
        let url = APIWeatherRequests.currentReportRequestForCity("Dublin")
        XCTAssertEqual(urlExpected, String(describing: url))
    }
    
}
