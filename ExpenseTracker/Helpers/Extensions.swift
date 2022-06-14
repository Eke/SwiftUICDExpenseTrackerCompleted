//
//  Extensions.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import Foundation
import SwiftUI

extension Double {
    
    var formattedCurrencyText: String {
        return Utils.numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }

    func converted(to: CurrencyRate) -> Self {
        if to.rate < self {
            return self / to.rate
        } else {
            return self * to.rate
        }
    }
    
}

extension Binding {
    func onChange(_ handler: @escaping (Value) -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler(newValue)
            }
        )
    }
}

extension Locale {
    /// Returns an SF Symbol currency image that match's the device's current locale, for instance dollar in North America, Indian rupee in India, etc.
    func currencySFSymbol(filled: Bool, withConfiguration configuration: UIImage.Configuration? = nil) -> String {
        // Default currency symbol will be the Animal Crossing Leaf coin 􁂬 to remain impartial to any specific country
        let defaultSymbol = "leaf.circle\(filled ? ".fill" : "")"

        guard let currencySymbolName = currencySymbolNameForSFSymbols() else { return defaultSymbol }

        let systemName = "\(currencySymbolName).circle\(filled ? ".fill" : "")"
        return systemName
    }

    private func currencySymbolNameForSFSymbols() -> String? {
        guard let currencySymbol = currencySymbol else { return nil }

        let symbols: [String: String] = [
            "$": "dollar",
            "¢": "cent",
            "¥": "yen",
            "£": "sterling",
            "₣": "franc",
            "ƒ": "florin",
            "₺": "turkishlira",
            "₽": "ruble",
            "€": "euro",
            "₫": "dong",
            "₹": "indianrupee",
            "₸": "tenge",
            "₧": "peseta",
            "₱": "peso",
            "₭": "kip",
            "₩": "won",
            "₤": "lira",
            "₳": "austral",
            "₴": "hryvnia",
            "₦": "naira",
            "₲": "guarani",
            "₡": "coloncurrency",
            "₵": "cedi",
            "₢": "cruzeiro",
            "₮": "tugrik",
            "₥": "mill",
            "₪": "shekel",
            "₼": "manat",
            "₨": "rupee",
            "฿": "baht",
            "₾": "lari",
            "R$":" brazilianreal"
        ]

        guard let currencySymbolName = symbols[currencySymbol] else { return nil }
        return "\(currencySymbolName)sign"
    }
}
