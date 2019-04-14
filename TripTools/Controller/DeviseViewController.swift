//
//  DeviseViewController.swift
//  TripTools
//
//  Created by Thomas Bouges on 2019-04-12.
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
    private let deviseService = DeviseService()
    private var deviseSymbol = "USD"
    private let devisesList =  [("AED", "Emirates Dirham"), ("AFN", "Afghan Afghani"),("ALL", "Albanian Lek"),("AMD", "Armenian Dram"),("ARS","Argentine Peso"),("AUD","Australian Dollar"),("BMD","Bermudan Dollar"),("BRL","Brazilian Real"),("BTC","Bitcoin"),("CAD","Canadian Dollar"),("CHF","Swiss Franc"),("COP","Colombian Peso"),("CUP","Cuban Peso"),("DZD","Algerian Dinar"),("EUR","Euro"),("GBP","British Pound Sterling"),("HKD","Hong Kong Dollar"),("INR","Indian Rupee"),("JPY","Japanese Yen"),("MAD","Moroccan Dirham"),("MXN","Mexican Peso"),("NZD","New Zealand Dollar"),("PLN","Polish Zloty"),("RUB","Russian Ruble"),("TRY","Turkish Lira"),("USD","US Dollar"),("VEF","Venezuelan Bolívar "),("VND","Vietnamese Dong"),("VUV","Vanuatu Vatu")]
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //initiate Label in "US Dollars"
        newDevise.text = devisesList[25].1
        //Create pickerView in an inputView when we click on newDeviseTextField
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(25, inComponent: 0, animated: true)
        newDevise.inputView = pickerView
      }
    
    //MARK: IBACTION
    @IBAction func validate(_ sender: UIButton) {
        showHidedeviseActivityButton(shown: true)
        
        guard let  numberInitialDevise = ourDevise.text else {return}
        
        addNewDevise(devise: deviseSymbol)
        
        deviseService.getDevise { (success, rate) in
            self.showHidedeviseActivityButton(shown: false)
            
            if success, let data = rate   {
                guard let number = Double(numberInitialDevise) else {return}
                let newDeviseNumber = number * data
                self.lookingDevise.text = String(newDeviseNumber)
            } else {
                self.showErrorAlert(message: "Problem during upload of Data")
            }
        }
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        ourDevise.resignFirstResponder()
    }
    
    //MARK: Methods
    
    private func addNewDevise(devise: String){
        deviseService.changeSymbol(symbol: devise)
        print(devise)
    }
    
    private func showErrorAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    //Method to show or hide activity indicator
    private func showHidedeviseActivityButton(shown: Bool) {
        deviseActivityButton.isHidden = !shown
    }
    
    
}

//MARK: PickerView Extension
extension DeviseViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    //Number of colomn on PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //Number of line on PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return devisesList.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return devisesList[row].1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newDevise.text = devisesList[row].1
        deviseSymbol = devisesList[row].0
        newDevise.resignFirstResponder()
    }
}


