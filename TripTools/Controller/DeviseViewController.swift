//
//  DeviseViewController.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-02-10.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import UIKit



class DeviseViewController: UIViewController{

    //MARK: Outlets
    @IBOutlet weak var ourDevise: UITextField!
    
    @IBOutlet weak var lookingDevise: UITextField!
    
    @IBOutlet weak var newDevise: UITextField!
    
    @IBOutlet weak var deviseActivityButton: UIActivityIndicatorView!
    //MARK: Properties
   
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
      }
    
    //MARK: IBACTION
    @IBAction func validate(_ sender: UIButton) {
       
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        
    }
    
    
}

