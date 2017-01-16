//
//  StringHelper.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 16/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation

extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    var uppercaseFirst: String {
        return first.uppercased() + String(characters.dropFirst())
    }
}
