//
//  ReverseLocationManager.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import CoreLocation

protocol  ReverseLocationManagerProtocol {
    weak var locationProtocol: LocationManagerProtocol? { get set }
    func getReverseLocation(_ location: CLLocation)
}

struct ReverseLocationManager: ReverseLocationManagerProtocol {
    weak internal var locationProtocol: LocationManagerProtocol?
    func getReverseLocation(_ location: CLLocation){
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(location)
            if error != nil {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                 self.locationProtocol?.didRetreiveReverseLocation(nil , placeMark: nil) // To show default location
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0]
                print(pm.locality ?? "NO location found")
                self.locationProtocol?.didRetreiveReverseLocation(location, placeMark: pm)
            }
            else {
                print("Problem with the data received from geocoder")
            }
        })
    }
}
