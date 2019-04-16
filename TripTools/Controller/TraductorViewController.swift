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
    
    //MARK: Properties
    private let translationService = TranslationService()
    private var langageFrom = "fr"
    private var langageTo = "en"
    private let pickerViewData  = [[("af","Afrikaans"),("ar","Arabic"),("bs","Bosnian"),("ca","Catalan"),("zh","Chinese"),("nl","Dutch"),("en","English"),("eo","Esperanto"),("fi","Finnish"),("fr","French"),("de","German"),("el","Greek"),("iw", "Hebrew"),("id","Indonesian"),("ga", "Irish"),("it", "Italian"),( "ja","Japanese"),("ko", "Korean"),("mt", "Maltese"),("no", "Norwegian"),("pl", "Polish"),("pt", "Portuguese"),("es","Spanish"),("tr","Turkish"),("vi", "Vietnamese")], [("af","Afrikaans"),("ar","Arabic"),("bs","Bosnian"),("ca","Catalan"),("zh","Chinese"),("nl","Dutch"),("en","English"),("eo","Esperanto"),("fi","Finnish"),("fr","French"),("de","German"),("el","Greek"),("iw", "Hebrew"),("id","Indonesian"),("ga", "Irish"),("it", "Italian"),( "ja","Japanese"),("ko", "Korean"),("mt", "Maltese"),("no", "Norwegian"),("pl", "Polish"),("pt", "Portuguese"),("es","Spanish"),("tr","Turkish"),("vi", "Vietnamese")]]
    
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // create a PickerView in an inputView load when textfield tapped
        let pickerView1 = UIPickerView()
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.selectRow(9, inComponent: 0, animated: true)
        pickerView1.selectRow(6, inComponent: 1, animated: true)
        langageToTextField.inputView = pickerView1
        langageFromTextField.inputView = pickerView1
        // Method to add toolbar to pickerView
        addToolBar()
       
    }
    
    //MARK: ABAction
    // Method to call Api and receive response
    @IBAction func TranslateText(_ sender: UIButton) {
        showHideTraductorActivityButton(shown: false)
        
        if let text = textToTranslateTextField.text {
            
            translationService.updateData(langageFrom: langageFrom, langageTo: langageTo, text: text)
            
            translationService.getTranslation{ (success, translation) in
                
                self.showHideTraductorActivityButton(shown: true)
                
                if success, let data: TranslationDataModel = translation   {
                    
                    
                    let textTranslated = data.data.translations[0].translatedText
                    self.textTranslatedTextField.text = textTranslated
                } else {
                    self.textTranslatedTextField.text = "Please Try again problem during translation process."
                }
            }
        }
       
    }
    
    @IBAction func dismissKeyBoard(_ sender: UITapGestureRecognizer) {
        
        textToTranslateTextField.resignFirstResponder()
        closeInputView()
       
    }
    
    //Method to show or hide activity indicator
    private func showHideTraductorActivityButton(shown: Bool) {
        traductorActivityButton.isHidden = shown
    }
}

//MARK: PickerView methods
extension TraductorViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    //Number of colomn on PickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //Number of line on PickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData[0].count
    }
    
    //
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewData[component][row].1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        langageFromTextField.text = pickerViewData[0][pickerView.selectedRow(inComponent: 0)].1
        langageToTextField.text = pickerViewData[0][pickerView.selectedRow(inComponent: 1)].1
        langageFrom = pickerViewData[0][pickerView.selectedRow(inComponent: 0)].0
        langageTo = pickerViewData[0][pickerView.selectedRow(inComponent: 1)].0
    }
    
    private func addToolBar(){
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let changeButton = UIBarButtonItem(title: "Change", style: UIBarButtonItem.Style.plain, target: self, action: #selector(closeInputView))
        changeButton.tintColor = #colorLiteral(red: 0.2584992142, green: 0, blue: 0.2979362861, alpha: 1)
        toolBar.setItems([changeButton], animated: false)
        self.langageFromTextField.inputAccessoryView = toolBar
        self.langageToTextField.inputAccessoryView = toolBar
        
    }
    
    @objc private func closeInputView(){
        
        self.langageFromTextField.resignFirstResponder()
        self.langageToTextField.resignFirstResponder()
    }
    
}



