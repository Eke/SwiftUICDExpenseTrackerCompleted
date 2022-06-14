//
//  FilterMonthsView.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterMonthsView: View {
    @Binding var selectedMonths: Set<String>
    private let months = Calendar.current.monthSymbols

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(months, id: \.self) { month in
                    FilterButtonView(
                        item: month,
                        isSelected: self.selectedMonths.contains(month),
                        text: month,
                        selectedColor: .green,
                        onTap: self.onTap
                    )
                    .padding(.leading, month == self.months.first ? 16 : 0)
                    .padding(.trailing, month == self.months.last ? 16 : 0)
                }
            }
        }
        .padding(.vertical)
    }

    

    func onTap(month: String) {
        if selectedMonths.contains(month) {
            selectedMonths.remove(month)
        } else {
            selectedMonths.insert(month)
        }
    }
}

struct FilterMonthsView_Previews: PreviewProvider {
    static var previews: some View {
        FilterMonthsView(selectedMonths: .constant(Set()))
    }
}
