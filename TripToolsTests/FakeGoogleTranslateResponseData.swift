//
//  FakeGoogleTranslateResponseData.swift
//  TripToolsTests
//
//  Created by Thomas Bouges on 2019-04-16.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation


class FakeGoogleTranslateResponseData {
    
    static let responseOk = HTTPURLResponse(url: URL(string: "http://pointpotn.com/")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    
    static let responseNot = HTTPURLResponse(url: URL(string: "http://pointpotn.com/")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    
    class responseError: Error {}
    static let error = responseError()
    
    static var responseCorrectData: Data {
        let bundle = Bundle(for: FakeGoogleTranslateResponseData.self)
        let url = bundle.url(forResource: "TranslationResponse", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        return data
    }
    
    static let responseIncorrectData = "wrong".data(using: .utf8)!
    
}


