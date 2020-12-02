//
//  CurrencyCell.swift
//  Converter
//
//  Created by Саша Дранчук on 02.12.2020.
//

import UIKit

class CurrencyCell: UITableViewCell {

    @IBOutlet weak var cc: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    func updateCell(currency:Currency) {
        cc.text = currency.cc
        rate.text = String(currency.rate)
    }
}
