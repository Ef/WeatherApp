//
//  DateHelper.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

extension Date {
    func dayOfWeekInWords() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return (dateFormatter.string(from: self).capitalized)
    }

    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return dateFormatter.string(from: self).capitalized
    }

    func hourInWord() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self).capitalized
    }
}
