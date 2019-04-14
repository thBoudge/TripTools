//
//  URLRequestConstructor.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-13.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation


struct URLRequestConstructor {
    // Create Urlrequest from initialURL and Bundle
    static func buildURL(urlRequest: URLRequest, with parameters: [(String, Any)]) -> URLRequest {
        var urlRequest = urlRequest
        guard let url = urlRequest.url else { return urlRequest}
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            
            urlRequest.url = urlComponents.url
        }
        return urlRequest
    }
    
}
