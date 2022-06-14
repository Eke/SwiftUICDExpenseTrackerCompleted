//
//  SelectCurrencyView.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct SelectCurrencyView: View {

    @Binding var currency: Currency

    private let currencies = Currency.allCases

    var body: some View {
        HStack {
            Text("Currency")
            Picker(selection: $currency, label: Text("Currency")) {
                ForEach(currencies) { type in
                    let symbolName = type == .local ? Locale.current.currencySFSymbol(filled: false) : "eurosign.circle"
                    Image(systemName: symbolName)
                        .tag(type)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .padding(.all)
        .frame(height: 64)

    }
}

struct SelectCurrencyView_Previews: PreviewProvider {
    static var previews: some View {
        SelectCurrencyView(currency: .constant(.local))
    }
}
