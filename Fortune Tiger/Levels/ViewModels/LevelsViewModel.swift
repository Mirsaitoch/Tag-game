//
//  LevelsViewModel.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import Foundation
import SwiftUI

class LevelsViewModel: ObservableObject {
    @Published var levels: [Level]

    init() {
        if let savedLevels = UserDefaults.standard.data(forKey: "levels") {
            if let decodedLevels = try? JSONDecoder().decode([Level].self, from: savedLevels) {
                self.levels = decodedLevels
                return
            }
        }
        self.levels = [
            Level(size: 3, isClosed: false),
            Level(size: 4, isClosed: true),
            Level(size: 5, isClosed: true)
        ]
    }
    
    func unlockNextLevel(after size: Int) {
        if let index = levels.firstIndex(where: { $0.size == size }) {
            if index + 1 < levels.count {
                levels[index + 1].isClosed = false
                saveLevels()
            }
        }
    }
    
    private func saveLevels() {
        if let encodedLevels = try? JSONEncoder().encode(levels) {
            print("saved")
            UserDefaults.standard.set(encodedLevels, forKey: "levels")
        }
    }
}

struct Level: Identifiable, Codable {
    var id = UUID()
    let size: Int
    var isClosed: Bool
}
