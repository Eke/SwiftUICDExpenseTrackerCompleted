//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Alfian Losari on 19/04/20.
//  Copyright © 2020 Alfian Losari. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab: Tab = .dashbaord

    init() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithTransparentBackground()
        tabBarAppearance.backgroundColor = .clear
        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }

        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear

        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.red
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 22.0, weight: .semibold)
        ]
        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().backgroundColor = UIColor(named: "Colors/Background")
//        UINavigationBar.appearance().isTranslucent = true
    }

    var body: some View {
        ZStack(alignment: .topLeading) {
            TabView(selection: $selectedTab) {
                DashboardTabView().tag(Tab.dashbaord)
                    .background(SceneBackgroundView())

                LogsTabView().tag(Tab.log)

                MonthlySummaryTabView().tag(Tab.monthlySummary)
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .ignoresSafeArea()

            TabBar { newTab in
                selectedTab = newTab
            }
            .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
