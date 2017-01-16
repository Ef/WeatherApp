//
//  DataHelperTest.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

import XCTest
@testable import WeatherApp
class DataHelperTest: XCTestCase {

    override func setUp() {
    }
    override func tearDown() {
    }

    func testDayOfWeakInWords(){
        let dateString = "2017-01-15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let  date = dateFormatter.date(from: dateString)
        let weekInWords = date?.dayOfWeekInWords()
        XCTAssertEqual(weekInWords, "Sun")
    }

    func testDayOfWeek(){
        let dateString = "2017-01-15"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let  date = dateFormatter.date(from: dateString)
        let day = date?.dayOfWeek()
        XCTAssertEqual(day, "15/01")
    }

    func testHour(){
        let dateString = "2017-01-15 19:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let  date = dateFormatter.date(from: dateString)
        let day = date?.hourInWord()
        XCTAssertEqual(day, "19:00")
    }
}
