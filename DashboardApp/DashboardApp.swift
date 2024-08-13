//
//  ImmediaCDashboardApp.swift
//  ImmediaCDashboard
//
//  Created by Immediac on 13/06/2024.
//

import SwiftUI

@main
struct ImmediaCDashboardApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                SurveyView()
                    .tabItem {
                        Image(systemName: "pencil")
                        Text("Survey List")
                    }
                GraphView()
                    .tabItem {
                        Image(systemName: "chart.bar")
                        Text("Graphs")
                    }
            }
        }
    }
}
