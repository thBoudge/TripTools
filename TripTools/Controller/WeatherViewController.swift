//
//  WeatherViewController.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-15.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {

    //MARK: Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityNameLabel2: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherImage2: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel2: UILabel!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    
    //MARK: Properties
    private let locationManager = CLLocationManager()
    
    private let weatherService = WeatherService()
    let changeCityButton = UIButton(type: .system)
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationBarItems()
        getLocation()
        //Delay in order to do not cancel call getLocation()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.weatherService.updateDate(name: "New York")
            self.getWeatherValue(town: 0)
        }
    }
    
    //MARK: Methods
    //Methods to call API and Get response
    private func getWeatherValue(town: Int){
        
        showHideweatherActivityIndicatorButton(shown: true)
        
        weatherService.getWeather{ (success, weather) in
            
            self.showHideweatherActivityIndicatorButton(shown: false)
            
            if success, let data: WeatherDataModel = weather   {
                
                let townName = data.name
                let temperature = Int(data.main.temp)
                // load image according to int id condition from data
                let condition = data.weather[0].id
                let imageName = self.weatherService.updateWeatherImage(condition: condition)
                
                
                if town == 0 {
                    self.cityNameLabel.text = townName
                    self.temperatureLabel.text = String(temperature)+" °C"
                    self.weatherImage.image = UIImage(named: imageName)
                } else {
                    self.cityNameLabel2.text = townName
                    self.temperatureLabel2.text = String(temperature)+" °C"
                    self.weatherImage2.image = UIImage(named: imageName)
                }
            } else {
                self.cityNameLabel.text = "City Unavailable"
            }
        }
    }
    
    //Method to show or hide activity indicator
    private func showHideweatherActivityIndicatorButton(shown: Bool) {
        weatherActivityIndicator.isHidden = !shown
    }
    
}



// MARK:Button NavigationBar
extension WeatherViewController {
    
    private func setUpNavigationBarItems(){
        
        //create Button to change city on navigation bar
        
        changeCityButton.setImage(#imageLiteral(resourceName: "city"), for: .normal)
        changeCityButton.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        changeCityButton.contentMode = .scaleAspectFit
        changeCityButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        changeCityButton.addTarget(self, action: #selector(changeCity), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: changeCityButton)
        
    }
    
    @objc func changeCity(){
        
        let alert = UIAlertController(title: "Change City", message: "Please add a city name", preferredStyle: UIAlertController.Style.alert)
        
        //Create 3 button city1, city2 and cancel
        let change1 = UIAlertAction(title: "Change City 1", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            
            if let name = textField.text  {
                self.weatherService.updateDate(name: name)
                self.getWeatherValue(town: 0)
            }
        }
        
        let change2 = UIAlertAction(title: "Change City 2", style: .default) { (alertAction) in
            let textField = alert.textFields![0] as UITextField
            
            if let name = textField.text  {
                self.weatherService.updateDate(name: name)
                self.getWeatherValue(town: 1)
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default) { (alertAction) in }
        
        // create a text field
        alert.addTextField { (textField) in
            textField.placeholder = "Please add a city name"
            textField.textColor = .blue
        }
        
        //Change color Button
        change1.setValue(#colorLiteral(red: 0.2584992142, green: 0, blue: 0.2979362861, alpha: 1), forKey: "titleTextColor")
        change2.setValue(#colorLiteral(red: 0.2584992142, green: 0, blue: 0.2979362861, alpha: 1), forKey: "titleTextColor")
        cancel.setValue(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), forKey: "titleTextColor")
        //Add button to Alert
        alert.addAction(change1)
        alert.addAction(change2)
        alert.addAction(cancel)
        
        self.present(alert, animated:true, completion: nil)
        
    }
    
}
// MARK: Localisation Methods
extension WeatherViewController : CLLocationManagerDelegate{
    
    func getLocation(){
        
        locationManager.delegate = self
        //inform type of accuracy we need localisation
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // Ask costumer if he allows us to use This phone to gps
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count-1]
        //if correct data we stop localisation
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
        }
        print("lattitude : \(location.coordinate.latitude)\n longitude : \(location.coordinate.longitude)")
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        weatherService.updateData(latitude: latitude, longitude: longitude)
        
        getWeatherValue(town: 1)
        
    }
    
    
    //didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        cityNameLabel.text = "City Unavailable"
        
    }
   

}
