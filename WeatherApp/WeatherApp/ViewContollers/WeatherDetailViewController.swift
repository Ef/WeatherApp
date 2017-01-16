//
//  WeatherDetailViewController.swift
//  WeatherApp
//
//  Created by Edgar Lopes on 14/01/2017.
//  Copyright © 2017 Edgar Lopes. All rights reserved.
//

import UIKit
import CoreLocation

protocol WeatherDetailViewProtocol: class {
    var locationManager: LocationManagerProtocol! { get }
    var weatherManager: WeatherManagerProtocol! { get }

    func refreshWithLocation(_ location:LocationWeather?)
    func showTemp(forecast: Forecast)
    func dataModel(model:[DailyForecastDetail])
    func selectedDate()-> Date
    func hourlyDataModel(model:[Forecast])
}

class WeatherDetailViewController: UIViewController, WeatherDetailViewProtocol {
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailedDescription : UILabel!
    @IBOutlet weak var icon : UIImageView!
    @IBOutlet weak var range: UILabel!
    
    var dataModel: [DailyForecastDetail] = []
    var hourlyDataModel: [Forecast] = []
    var locationManager: LocationManagerProtocol! = LocationManager()
    var weatherManager: WeatherManagerProtocol! = WeatherManager()

    let itemsPerRow: CGFloat = 5
    let sectionInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let reuseIdentifier = "DailyCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.weatherDetailViewProtocol = self
        weatherManager.weatherDetailViewProtocol = self
        setUpUI()
        collectionView.allowsMultipleSelection = false
         NotificationCenter.default.addObserver(self, selector: #selector(WeatherDetailViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setUpUI() {
        locationManager.retreiveLocation()
    }

    func refreshWithLocation(_ location: LocationWeather?) {
        locationName.text = location?.city
        weatherManager.getHourlyForecastInDetail(location!)
        weatherManager.getForecastForTheWeek(location!)
        weatherManager.getCurrentReport(location!)
    }

    func showTemp(forecast: Forecast) {
        temperature.text = String(forecast.detail.temp) + "˚"
        detailedDescription.text = forecast.detailedDescription.uppercaseFirst
        icon.image = IconHelper.getIcon(forecast.iconID)
    }
    func dataModel(model:[DailyForecastDetail]){
        range.text = String(model[0].temp.min) + "˚ " + String(model[0].temp.max) + "˚"
        dataModel = model
        self.collectionView?.reloadData()
        collectionView.selectItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.left)

    }
    
    func selectedDate() -> Date {
        return Date()
    }

    func hourlyDataModel(model: [Forecast]) {
        hourlyDataModel = model
        self.tableView.reloadData()
    }

    func rotated() {
        self.collectionView.reloadData()
    }
}

extension WeatherDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                      for: indexPath) as! WaetherWeekCell
        let dailyForecast = dataModel[indexPath.row]
        let date = Date(timeIntervalSince1970: dailyForecast.date)
        cell.range.text = String(dailyForecast.temp.min) + "˚ " + String(dailyForecast.temp.max) + "˚ "
        cell.day.text = (date.dayOfWeekInWords())!
        let description = dailyForecast.iconID
        cell.icon.image = IconHelper.getIcon(description)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = UIScreen.main.bounds.width
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension WeatherDetailViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hourlyDataModel.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "DailyCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                 for: indexPath) as! WeatherDailyCell
        cell.backgroundColor = UIColor.clear
        let hourDetail = hourlyDataModel[indexPath.row]
        cell.day.text = hourDetail.date.hourInWord()!
        cell.temperature.text = String(hourDetail.detail.temp) + "˚"
        cell.icon.image = IconHelper.getIcon(hourDetail.iconID)
        return cell
    }
}
