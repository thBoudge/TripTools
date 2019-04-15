//
//  WeatherService.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-15.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation

class WeatherService {
    
    //MARK: Properties
    private let WEATHER_URL = URL(string: "http://api.openweathermap.org/data/2.5/weather")!
    private let APP_ID = valueForAPIKey(named:"WeatherAPIKey")
    
    private var bundle : [(String, Any)]
    
    private var task : URLSessionDataTask?
    
    private var weatherSession = URLSession()
    
    //Mark: Init()
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
        bundle = []
    }
    
    //MARK: Methods
    //Methods to build bundle to make a API CALL
    func updateData(latitude: String, longitude: String){
        bundle = [("appid", APP_ID),("units","metric"),("lat", latitude), ("lon", longitude) ]
    }
    
    func updateDate(name: String){
        bundle = [("appid", APP_ID),("units","metric"),("q", name) ]
    }
    
    //Methods That called and return response
    func getWeather(callback: @escaping (Bool, WeatherDataModel?) -> Void){
        
        let request = URLRequestConstructor.buildURL(urlRequest: URLRequest(url: WEATHER_URL) , with: bundle)
        print(request)
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                
                //Check if data != nil and error is = nil
                guard let data = data, error == nil else {
                    callback(false, nil)
                    print("error")
                    return
                }
                
                //Control that response is a  HTTPURLResponse and that status is 200
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("response")
                    return
                }
                
                //Translation JSON in String
                if let responseJSON = try? JSONDecoder().decode(WeatherDataModel.self, from: data){
                    callback(true,responseJSON)
                }
            }
        }
        task?.resume()
    }
    
    //Methods to change UIImage logo to translate weather[0].id in Imagename
    func updateWeatherImage(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...902, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
        
    }
    
}
