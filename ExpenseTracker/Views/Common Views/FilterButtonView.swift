//
//  FilterButtonView.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 14.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI

struct FilterButtonView<T>: View {

    var item: T
    var isSelected: Bool
    var text: String
    var selectedColor: Color
    var onTap: (T) -> ()

    var body: some View {
        Button(action: {
            self.onTap(self.item)
        }) {
            HStack(spacing: 8) {
                Text(text.capitalized)
                    .fixedSize(horizontal: true, vertical: true)

                if isSelected {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .frame(height: 44)
            .background(Blur(style: .prominent))
            .background(isSelected ? selectedColor : Color.clear)
            .mask(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .foregroundColor(Color.white)
    }


}

struct FilterButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FilterButtonView(
            item: "Preview",
            isSelected: false,
            text: "Preview",
            selectedColor: .red
        ) { _ in }
    }
}
