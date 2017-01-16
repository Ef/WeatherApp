//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import Foundation
import CoreLocation
import Gloss

protocol LocationManagerProtocol: class {
    weak var weatherDetailViewProtocol: WeatherDetailViewProtocol? { get set }
    var reverseManager: ReverseLocationManagerProtocol! { get }
    func retreiveLocation()
    func didRetreiveReverseLocation(_ location: CLLocation?, placeMark: CLPlacemark?)
}

class LocationManager: NSObject, LocationManagerProtocol, CLLocationManagerDelegate {
    var manager:CLLocationManager! = CLLocationManager()
    weak internal var weatherDetailViewProtocol: WeatherDetailViewProtocol?
    var reverseManager: ReverseLocationManagerProtocol! = ReverseLocationManager()

    func retreiveLocation()  {
        reverseManager.locationProtocol = self
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager:CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("locations = \(locations)")
        manager.stopUpdatingLocation()
        reverseManager.getReverseLocation(locations.first!)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error description = \(error.localizedDescription)")
        manager.stopUpdatingLocation()
        // Default in case of fail
        let myLocation  = "Dublin"
        let myCountryCode  = "ie"
        let myCountry  = "Ireland"
        let lat = 53.3498
        let long = 6.2603
        let locationWeather = LocationWeather(coord: Coord(lat: lat, long: long),
                                              city: myLocation,
                                              country: myCountry,
                                              isoCode: myCountryCode)

        weatherDetailViewProtocol!.refreshWithLocation(locationWeather)
    }

    func didRetreiveReverseLocation(_ location: CLLocation?, placeMark: CLPlacemark?) {
        var myLocation = placeMark?.locality
        var myCountryCode = placeMark?.isoCountryCode
        var myCountry = placeMark?.country
        var lat = location?.coordinate.latitude
        var long = location?.coordinate.longitude
        if location == nil { // Default values
            myLocation = "Dublin"
            myCountryCode = "ie"
            myCountry = "Ireland"
            lat = 53.3498
            long = 6.2603

        }
        let locationWeather = LocationWeather(coord: Coord(lat: lat!, long: long!),
                                              city: myLocation,
                                              country: myCountry,
                                              isoCode: myCountryCode)

        weatherDetailViewProtocol!.refreshWithLocation(locationWeather)
    }
}
