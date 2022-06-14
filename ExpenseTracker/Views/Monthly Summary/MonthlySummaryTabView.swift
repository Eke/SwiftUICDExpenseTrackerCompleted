//
//  MonthlySummaryTabView.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct MonthlySummaryTabView: View {
    @State var selectedMonths: Set<String> = Set()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Divider()
                FilterMonthsView(
                    selectedMonths: $selectedMonths
                )
                Divider()
                LogListView(
                    predicate: ExpenseLog.predicate(
                        months: Array(selectedMonths)
                    ),
                    sortDescriptor: ExpenseLogSort(
                        sortType: .date,
                        sortOrder: .descending
                    ).sortDescriptor
                )
            }
            .navigationBarTitle("Monthly Summary", displayMode: .inline)
        }
    }
}

struct MonthlySummary_Previews: PreviewProvider {
    static var previews: some View {
        MonthlySummaryTabView()
    }
}
