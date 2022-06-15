//
//  TabBar.swift
//  ExpenseTracker
//
//  Created by Erekle Meskhi on 15.06.22.
//  Copyright © 2022 Alfian Losari. All rights reserved.
//

import SwiftUI
import RiveRuntime

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

struct TabBar: View {
    typealias TabSelectedCallback = (Tab) -> ()

    private let onTabSelected: TabSelectedCallback

    @State var selectedTab: Tab = .dashbaord {
        didSet {
            onTabSelected(selectedTab)
        }
    }

    init(onSelected: @escaping TabSelectedCallback) {
        onTabSelected = onSelected
    }

    var body: some View {
        VStack {
            Spacer()
            HStack() {
                content
            }
            .padding(
                EdgeInsets(top: 16.0, leading: 28.0, bottom: 34.0, trailing: 28.0)
            )
            .frame(maxWidth: .infinity, maxHeight: 96, alignment: .top)
            .background(Blur(style: .prominent))
            .background(
              LinearGradient(
                gradient: Gradient(
                  colors: [
                    Color(red: 0.08, green: 0.08, blue: 0.09).opacity(0.7),
                    Color(red: 0.08, green: 0.08, blue: 0.09)
                  ]
                ),
                startPoint: .bottomLeading,
                endPoint: .topTrailing
              )
            )
        }
    }

    var content: some View {
        ForEach(tabItems) { item in
            Button {
                withAnimation {
                    selectedTab = item.id
                }
            } label: {
                item.icon.view()
                    .frame(width: 44.0, height: 44.0)
                    .frame(maxWidth: .infinity)
                    .opacity(selectedTab == item.id ? 1 : 0.8)
                    .background(
                        VStack {
                            RoundedRectangle(cornerRadius: 2)
                                .frame(width: selectedTab == item.id ? 20 : 0, height: 4)
                                .offset(y: -4)
                                .opacity(selectedTab == item.id ? 1 : 0)
                            Spacer()
                        }
                    )
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(onSelected: { _ in })
    }
}

struct TabItem: Identifiable {
    let id: Tab
    let icon: RiveViewModel
}

var tabItems = [
    TabItem(
        id: .dashbaord,
        icon: RiveViewModel(
            fileName: "ecomerce-icons",
            artboardName: "pig"
        )
    ),
    TabItem(
        id: .log,
        icon: RiveViewModel(
            fileName: "ecomerce-icons",
            artboardName: "scan"
        )
    ),
    TabItem(
        id: .monthlySummary,
        icon: RiveViewModel(
            fileName: "ecomerce-icons",
            artboardName: "bank"
        )
    ),
]

enum Tab: String, Equatable {
    case dashbaord
    case log
    case monthlySummary
}

extension Tab: Identifiable {
    var id: String { rawValue }
}
