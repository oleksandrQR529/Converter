//
//  ConverterVC.swift
//  Converter
//
//  Created by Саша Дранчук on 02.12.2020.
//

import UIKit

class ConverterVC: UIViewController {
    
    @IBOutlet weak var firstCCLbl: UILabel!
    @IBOutlet weak var secondCCLbl: UILabel!
    @IBOutlet weak var firstConvertValue: UITextField!
    @IBOutlet weak var firstCurrencyPicker: UIPickerView!
    @IBOutlet weak var secondCurrencyPicker: UIPickerView!
    @IBOutlet weak var secondConverterValue: UITextField!
    
    var currencies: [Currency] = []
    let converter = DataProcessing.instance

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }
    
    func initUI() {
        firstCurrencyPicker.dataSource = self
        firstCurrencyPicker.delegate = self
        
        secondCurrencyPicker.dataSource = self
        secondCurrencyPicker.delegate = self
        
        self.clickableLabel()
    }
    
    @IBAction func firstConvertValueChanged() {
        self.convertCurrencies()
    }
    
    @IBAction func secondConvertValueChanged() {
        self.convertCurrencies()
    }
    
    @IBAction func firstCCLblTapFunction(sender: UITapGestureRecognizer) {
        if firstCurrencyPicker.isHidden {
            firstCurrencyPicker.isHidden = false
        }else {
            firstCurrencyPicker.isHidden = true
        }
    }
    
    @IBAction func secondCCLblTapFunction(sender: UITapGestureRecognizer) {
        if secondCurrencyPicker.isHidden {
            secondCurrencyPicker.isHidden = false
        }else {
            secondCurrencyPicker.isHidden = true
        }
    }
    
}

extension ConverterVC: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencies[row].cc
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = currencies[row]
        
        if pickerView == firstCurrencyPicker {
            firstCCLbl.text = currency.cc
        }else {
            secondCCLbl.text = currency.cc
        }
        
        self.convertCurrencies()
    }
    
}

extension ConverterVC {
    
    func convertCurrencies() {
        let value = converter.convert(firstCurrency: currencies[firstCurrencyPicker.selectedRow(inComponent: 0)], firstCurrencyValue: Double(firstConvertValue.text!) ?? 0.0, secondCurrency: currencies[secondCurrencyPicker.selectedRow(inComponent: 0)])
        
        secondConverterValue.text = String(round(value * 1000) / 1000)
    }
    
    func clickableLabel() {
        
        let firstCCLblTap = UITapGestureRecognizer(target: self, action: #selector(ConverterVC.firstCCLblTapFunction))
        firstCCLbl.isUserInteractionEnabled = true
        firstCCLbl.addGestureRecognizer(firstCCLblTap)
        
        let secondCCLblTap = UITapGestureRecognizer(target: self, action: #selector(ConverterVC.secondCCLblTapFunction))
        secondCCLbl.isUserInteractionEnabled = true
        secondCCLbl.addGestureRecognizer(secondCCLblTap)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
