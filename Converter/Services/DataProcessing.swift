//
//  DataProcessing.swift
//  Converter
//
//  Created by Саша Дранчук on 02.12.2020.
//

import Foundation

class DataProcessing {
    static let instance = DataProcessing()
    
    func convert(firstCurrency: Currency, firstCurrencyValue: Double, secondCurrency: Currency) -> Double {
        let value = convertCurrencyToUAH(currencyValue: firstCurrencyValue, rate: firstCurrency.rate)
        let result = convertUahToCurrency(uahValue: value.uah, rate: secondCurrency.rate).currency
        return result
    }
}
