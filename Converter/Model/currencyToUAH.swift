//
//  currencyToUAH.swift
//  Converter
//
//  Created by Саша Дранчук on 02.12.2020.
//

import Foundation

struct convertCurrencyToUAH {
    var currencyValue: Double
    var rate: Double
    var uah: Double {
        get {
            return currencyValue * rate
        }
        set(nUah) {
            currencyValue = nUah / rate
        }
    }
}
