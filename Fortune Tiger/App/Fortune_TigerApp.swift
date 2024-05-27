//
//  Fortune_TigerApp.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import SwiftUI

@main
struct Fortune_TigerApp: App {
    @StateObject private var settingsViewModel = SettingsViewModel()
    @StateObject private var levelsViewModel = LevelsViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(settingsViewModel)
                .environmentObject(levelsViewModel)
        }
    }
}
