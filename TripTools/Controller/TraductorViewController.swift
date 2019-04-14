//
//  TraductorViewController.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-12.
//  Copyright © 2019 Thomas Bouges. All rights reserved.
//

import UIKit

class TraductorViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var textToTranslateTextField: UITextField!
    @IBOutlet weak var textTranslatedTextField: UITextView!
    @IBOutlet weak var langageFromTextField: UITextField!
    @IBOutlet weak var langageToTextField: UITextField!
   
    @IBOutlet weak var traductorActivityButton: UIActivityIndicatorView!
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    //MARK: ABAction
    // Method to call Api and receive response
    @IBAction func TranslateText(_ sender: UIButton) {
        
       
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        
       
    }
    
    
}



