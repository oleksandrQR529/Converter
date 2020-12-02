//
//  uahToCurrency.swift
//  Converter
//
//  Created by Саша Дранчук on 02.12.2020.
//

import Foundation

struct convertUahToCurrency {
    var uahValue: Double
    var rate: Double
    var currency: Double {
        get {
            return uahValue / rate
        }
        set(nCurrency) {
            uahValue = nCurrency * rate
        }
    }
}
