//
//  ApiKeys.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-13.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import Foundation

func valueForAPIKey(named keyname:String) -> String {
    let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
    let plist = NSDictionary(contentsOfFile:filePath!)
    let value = plist?.object(forKey: keyname) as! String
    return value
}
