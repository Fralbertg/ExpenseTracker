//
//  Formatters.swift
//  ExpenseTracker
//
//  Created by Francisco Albert Garcia on 15/03/2020.
//  Copyright © 2020 Francisco Albert Garcia. All rights reserved.
//

import Foundation

public class Formatters {
    static func formatStringToNumber(stringNumber: String) -> Double {
        return Double(stringNumber ?? "0") ?? 0
    }
    
    static func formatNumberToString(doubleNumber: Double) -> String {
        let formatter = NumberFormatter()
        let decimalPoint = Locale(identifier: NSLocale.current.languageCode ?? "en").decimalSeparator
        let midPoint = Locale(identifier: NSLocale.current.languageCode ?? "en").groupingSeparator

        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        formatter.numberStyle = .decimal
        
        formatter.locale = Locale(identifier: NSLocale.current.languageCode ?? "zh")
        var result = formatter.string(from: doubleNumber as NSNumber) ?? ""
        
        var currency = NSLocale.current.currencySymbol
        
        return "\(result)\(currency ?? "")"
    }
    
}
