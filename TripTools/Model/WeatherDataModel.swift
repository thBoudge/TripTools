//
//  WeatherDataModel.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-15.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation

struct WeatherDataModel: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let id: Int
    let name: String
    let cod: Int
}

struct Coord: Codable {
    let lon, lat: Int
}

struct Main: Codable {
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
    }
}

struct Sys: Codable {
    let message: Double
    let country: String
}

struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}



