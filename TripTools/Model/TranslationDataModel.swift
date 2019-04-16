//
//  TranslationDataModel.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-16.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation

import Foundation

struct TranslationDataModel: Codable {
    let data: DataClass
}

struct DataClass: Codable {
    let translations: [Translation]
}

struct Translation: Codable {
    let translatedText: String
}

