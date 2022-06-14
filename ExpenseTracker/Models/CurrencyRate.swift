//
//  CurrencyRate.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import Foundation

enum Currency: String, CaseIterable {
    case local, euro
}

extension Currency: Identifiable {
    var id: String { rawValue }
}

struct CurrencyRate: Codable {
    let rate: Double
}
