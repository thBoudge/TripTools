//
//  WeatherViewController.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-12.
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
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   

}
