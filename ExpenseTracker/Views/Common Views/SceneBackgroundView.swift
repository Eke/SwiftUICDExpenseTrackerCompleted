//
//  SceneBackgroundView.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI
import RiveRuntime

struct SceneBackgroundView: View {
    var body: some View {
        ZStack {
            RiveViewModel(fileName: "shapes", fit: .fitCover).view()
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .topLeading
                )
                .ignoresSafeArea()
                .blur(radius: 100)
            Color("Colors/Background")
                .opacity(0.75)
                .ignoresSafeArea()
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .ignoresSafeArea()
    }
}

struct SceneBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        SceneBackgroundView()
    }
}
