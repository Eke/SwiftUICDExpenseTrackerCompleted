//
//  FilterCategoriesView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterCategoriesView: View {
    
    @Binding var selectedCategories: Set<Category>
    private let categories = Category.allCases
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(categories) { category in
                    FilterButtonView(
                        item: category,
                        isSelected: self.selectedCategories.contains(category),
                        text: category.rawValue,
                        selectedColor: category.color,
                        onTap: self.onTap
                    )
                        
                        .padding(.leading, category == self.categories.first ? 16 : 0)
                        .padding(.trailing, category == self.categories.last ? 16 : 0)
                    
                }
            }
        }
        .padding(.vertical)
    }
    
    func onTap(category: Category) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }
}


struct FilterCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterCategoriesView(selectedCategories: .constant(Set()))
    }
}
