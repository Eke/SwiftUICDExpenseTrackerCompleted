//
//  CategoryRowView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct CategoryRowView: View {
    let category: Category
    let sum: Double
    
    var body: some View {
        HStack {
            CategoryImageView(category: category)
            Text(category.rawValue.capitalized)
                .font(.headline)
            Spacer()
            Text(sum.formattedCurrencyText)
                .font(.body)
        }
        .padding(12)
        .background(Blur(style: .prominent))
        .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

struct CategoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRowView(category: .donation, sum: 2500)
    }
}
