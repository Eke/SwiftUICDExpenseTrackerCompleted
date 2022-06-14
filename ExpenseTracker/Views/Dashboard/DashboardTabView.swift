//
//  DashboardTabView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI
import CoreData

struct DashboardTabView: View {
    
    @Environment(\.managedObjectContext)
    var context: NSManagedObjectContext
    
    @State var totalExpenses: Double?
    @State var categoriesSum: [CategorySum]?
    @State var selectedCurrency: Currency = .local
    @State var selectedCurrencyRate: CurrencyRate = CurrencyRate(rate: 1.0)
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 4) {
                if let total = totalExpenses {
                    Text("Total expenses")
                        .font(.headline)
                    Text(total.converted(to: selectedCurrencyRate).formattedCurrencyText)
                        .font(.largeTitle)
                }
            }
            
            if categoriesSum != nil {
                if totalExpenses != nil && totalExpenses! > 0 {
                    PieChartView(
                        data: categoriesSum!.map { ($0.sum, $0.category.color) },
                        style: Styles.pieChartStyleOne,
                        form: CGSize(width: 300, height: 240),
                        dropShadow: false
                    )
                }
                
                Divider()

                SelectCurrencyView(currency: $selectedCurrency.onChange({ currency in
                    load(currency: currency)
                }))

                Divider()

                List {
                    Text("Breakdown").font(.headline)
                    ForEach(self.categoriesSum!) {
                        CategoryRowView(category: $0.category, sum: $0.sum.converted(to: selectedCurrencyRate))
                    }
                }
            }
            
            if totalExpenses == nil && categoriesSum == nil {
                Text("No expenses data\nPlease add your expenses from the logs tab")
                    .multilineTextAlignment(.center)
                    .font(.headline)
                    .padding(.horizontal)
            }
        }
        .frame(
          minWidth: 0,
          maxWidth: .infinity,
          minHeight: 0,
          maxHeight: .infinity,
          alignment: .topLeading
        )
        .padding(.top)
        .onAppear(perform: fetchTotalSums)
    }

    func load(currency: Currency) {
        if currency == .local {
            selectedCurrencyRate = CurrencyRate(rate: 1.0)
            return
        }

        Task.detached(priority: .userInitiated) {
            do {
                let item = try await ApiClient.getCurrencyRate()
                selectedCurrencyRate = item
            } catch {
                // TODO:: error handling
            }
        }
    }
    
    func fetchTotalSums() {
        ExpenseLog.fetchAllCategoriesTotalAmountSum(context: self.context) { (results) in
            guard !results.isEmpty else { return }
            
            let totalSum = results.map { $0.sum }.reduce(0, +)
            self.totalExpenses = totalSum
            self.categoriesSum = results.map({ (result) -> CategorySum in
                return CategorySum(sum: result.sum, category: result.category)
            })
        }
    }
}


struct CategorySum: Identifiable, Equatable {
    let sum: Double
    let category: Category
    
    var id: String { "\(category)\(sum)" }
}


struct DashboardTabView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardTabView()
    }
}
