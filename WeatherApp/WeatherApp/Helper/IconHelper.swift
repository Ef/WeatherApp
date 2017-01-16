//
//  IconHelper.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 15/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import UIKit
class IconHelper  {
    static func getIcon(_ code: Int)  -> UIImage {
        var image: UIImage
        switch code {
        case 200 ... 232:
            image = UIImage(named: "Flash")!
            break
        case 300 ... 321:
             image = UIImage(named: "CloudAndSun")!
            break
        case 500 ... 531:
             image = UIImage(named: "Rain")!
            break
        case 600 ... 622:
            image = UIImage(named: "Snow")!
            break
        case 701 ... 781:
            image = UIImage(named: "Haze")!
            break
        case 800:
            image = UIImage(named: "Sun")!
            break
        case 801 ... 804:
            image = UIImage(named: "Cloud")!
            break
        default:
             image = UIImage(named: "Sun")!
        }
        return image
    }
}
