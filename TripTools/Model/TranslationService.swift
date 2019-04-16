//
//  translationService.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-12.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation

class TranslationService {
    //MARK: Properties
    private let translationGoogleURL = URL(string: "https://translation.googleapis.com/language/translate/v2")!
    private let APP_ID = valueForAPIKey(named:"GoogleAPIKey")
    private var bundle : [(String, Any)]
    
    private var task : URLSessionDataTask?
    
    private var translationSession = URLSession()
    //MARK: init()
    init(translationSession: URLSession = URLSession(configuration: .default)) {
        self.translationSession = translationSession
        bundle = []
    }
    //MARK:  Methods
    // Method to build Bundle to build URL
    func updateData(langageFrom: String, langageTo: String, text: String){
        bundle = [("key", APP_ID), ("source", langageFrom), ("target", langageTo), ("q", text), ("format", "text") ]
    }
    
    //Method to call and receive response
    func getTranslation(callback: @escaping (Bool, TranslationDataModel?) -> Void){
        
        let request = URLRequestConstructor.buildURL(urlRequest: URLRequest(url: translationGoogleURL) , with: bundle)
        
        task?.cancel()
        
        task = translationSession.dataTask(with: request){ (data, response, error) in
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
                if let responseJSON = try? JSONDecoder().decode(TranslationDataModel.self, from: data){
                    callback(true,responseJSON)
                }
            }
        }
        task?.resume()
    }
    
}
