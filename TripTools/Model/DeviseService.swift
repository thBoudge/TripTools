//
//  DeviseService.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-13.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation



class DeviseService {
    
    //MARK: Properties
    private let fixerURL = URL(string: "http://data.fixer.io/api/latest")!
    private let accessKey = valueForAPIKey(named:"FixerAPIKey")
    private var symbols: String
    
    private var task : URLSessionDataTask?
    
    private var deviseSession : URLSession
    
    //Mark: Init()
    init(deviseSession: URLSession = URLSession(configuration: .default)) {
        self.deviseSession = deviseSession
        self.symbols = "USD"
    }
    
    //MARK: Methods
    
    //Methdos to Change devise
    func changeSymbol(symbol: String) -> Void {
        symbols = symbol
    }
    
    //Methods That called and return response
    func getDevise(callback: @escaping (Bool, Double?) -> Void) {
        
        let request = URLRequestConstructor.buildURL(urlRequest: URLRequest(url: fixerURL) , with: [("access_key", accessKey), ("symbols", symbols)])
        
        print(request)
        
        task?.cancel()
        
        task = deviseSession.dataTask(with: request){ (data, response, error) in
            DispatchQueue.main.async {
                //Check if data != nil and error is = nil
                guard let data = data, error == nil else {
                    callback(false, nil)
                    
                    return
                }
                // control that response is a  HTTPURLResponse and that status is 200
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    
                    return
                }
                
                // MARK: - 5 Translation JSON in String
                if let responseJSON = try? JSONDecoder().decode(Devise.self, from: data){ //guard let
                    let value = responseJSON.rates[self.symbols]
                    callback(true,value)
                    print(value!)
                }
            }
        }
        
        task?.resume()
        
    }
}
