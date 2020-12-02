//
//  ViewController.swift
//  Converter
//
//  Created by Саша Дранчук on 01.12.2020.
//

import UIKit

class CurrentRatesVC: UIViewController {
    
    @IBOutlet weak var currenciesTable: UITableView!
    
    private var currencies: [Currency] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    func initUI() {
        let dataUrl = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"
        getCurrencies(dataUrl: dataUrl)
        
        currenciesTable.delegate = self
        currenciesTable.dataSource = self
    }
    
    func getCurrencies(dataUrl: String) {
        NetworkService.instance.getCurrensies(dataUrl: dataUrl) { (currency) in
            self.currencies = currency
            self.currenciesTable.reloadData()
        } onError: { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let converterVC = segue.destination as? ConverterVC {
            converterVC.currencies = self.currencies
        }
    }
    
}

extension CurrentRatesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell") as? CurrencyCell {
            cell.updateCell(currency: currencies[indexPath.row])
            return cell
        }else {
            return CurrencyCell()
        }
    }
    
    
}

