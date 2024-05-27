//
//  SettingsViewModel.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import Foundation

import Foundation
import Combine

class SettingsViewModel: ObservableObject {
    private let vibrationKey = "isVibrationEnabled"
    
    @Published var isVibrationEnabled: Bool {
        didSet {
            UserDefaults.standard.set(isVibrationEnabled, forKey: vibrationKey)
        }
    }
    
    init() {
        self.isVibrationEnabled = UserDefaults.standard.bool(forKey: vibrationKey)
    }
}
