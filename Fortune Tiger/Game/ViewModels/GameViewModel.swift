//
//  GameViewModel.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import Foundation
import SwiftImage
import SwiftUI

import Foundation
import SwiftImage
import SwiftUI

extension GameView {
    @MainActor
    class ViewModel: ObservableObject {
        @Published var remainingTime = Consts.gameRound {
            didSet {
                remainingTimeString = "\(remainingTime / 60):\(remainingTime % 60 < 10 ? "0" : "")\(remainingTime % 60)"
            }
        }
        
        @Published private(set) var remainingTimeString = "3:00"
        @Published var statusGameText = "Pause"
        @Published var isPlay = true
        @Published var roundIsStarted = false
        @Published var isLoading = true
        @Published var gameIsEnded = false
        @Published var imageParts: [[UIImage]] = []
        @Published var name = Consts.tigerNames.randomElement()!
        
        private var levelsViewModel: LevelsViewModel
        
        init(levelsViewModel: LevelsViewModel) {
            self.levelsViewModel = levelsViewModel
            Task {
                await loadImageParts(name: name)
            }
        }
        
        // Асинхронный метод для создания частей изображения
        func loadImageParts(name: String) async {
            guard let pic = SwiftImage.Image<RGBA<UInt8>>(named: name) else {
                return
            }
            var img: [[UIImage]] = []
            for x in 0..<Consts.columns {
                img.append([])
                for y in 0..<Consts.rows {
                    let widthPart = pic.width / Consts.columns
                    let heightPart = pic.height / Consts.rows
                    let xRange = (widthPart * x)..<(widthPart * (x + 1))
                    let yRange = (heightPart * y)..<(heightPart * (y + 1))
                    
                    img[x].append(pic[xRange, yRange].uiImage)
                    
                }
            }
            await MainActor.run {
                self.imageParts = img
                self.shuffle()
                self.isLoading = false
                self.roundIsStarted = true
            }
        }
        
        func restart() {
            isPlay = true
            shuffle()
            remainingTime = Consts.gameRound
            gameIsEnded = false
            roundIsStarted = true
        }
        
        func continueGame() {
            isPlay = true
            statusGameText = "Active"
        }
        
        func pauseGame() {
            isPlay = false
            statusGameText = "Pause"
        }
        
        func looser() {
            statusGameText = "Try again"
            isPlay = false
            gameIsEnded = true
            roundIsStarted = false
        }
        
        func updateGameStatus() {
            if checkOfCorrectness() {
                isPlay = false
                gameIsEnded = true
                statusGameText = "Great"
                levelsViewModel.unlockNextLevel(after: Consts.columns)
                roundIsStarted = false
            }
        }
        
        // Данные игры
        @Published var data = initialData
        
        func shuffle() {
            data = GameView.ViewModel.initialData
            performRandomMoves(count: 1000)
        }
        
        private func performRandomMoves(count: Int) {
            for _ in 0..<count {
                let emptyCoord = freeCoord
                let possibleMoves = getPossibleMoves(for: emptyCoord)
                if let move = possibleMoves.randomElement() {
                    swap(emptyCoord, move)
                }
            }
        }
        
        private func getPossibleMoves(for coord: Coord) -> [Coord] {
            var moves: [Coord] = []
            
            if coord.x > 0 {
                moves.append(Coord(coord.x - 1, coord.y))
            }
            if coord.x < Consts.columns - 1 {
                moves.append(Coord(coord.x + 1, coord.y))
            }
            if coord.y > 0 {
                moves.append(Coord(coord.x, coord.y - 1))
            }
            if coord.y < Consts.rows - 1 {
                moves.append(Coord(coord.x, coord.y + 1))
            }
            
            return moves
        }
        
        static var initialData: [[Coord?]] {
            var dat = [[Coord?]]()
            for x in 0..<Consts.columns {
                dat.append([Coord?]())
                for y in 0..<Consts.rows {
                    dat[x].append(Coord(x, y))
                }
            }
            dat[dat.count - 1][dat.last!.count - 1] = nil
            return dat
        }
        
        
        func getData(at coord: Coord) -> Coord? {
            guard 0..<Consts.rows ~= coord.y, 0..<Consts.columns ~= coord.x else { return nil }
            return data[coord.x][coord.y]
        }
        
        func updateData(at coord: Coord, _ newValue: Coord?) {
            guard 0..<Consts.rows ~= coord.y, 0..<Consts.columns ~= coord.x else { return }
            data[coord.x][coord.y] = newValue
        }
        
        func swap(_ lhs: Coord, _ rhs: Coord) {
            let val = getData(at: lhs)
            data[lhs.x][lhs.y] = getData(at: rhs)
            data[rhs.x][rhs.y] = val
        }
        
        var freeCoord: Coord {
            for x in 0..<Consts.columns {
                for y in 0..<Consts.rows {
                    if data[x][y] == nil {
                        return Coord(x, y)
                    }
                }
            }
            fatalError()
        }

        func checkOfCorrectness() -> Bool {
            for x in 0..<Consts.columns {
                for y in 0..<Consts.rows {
                    if GameView.ViewModel.initialData[x][y] != data[x][y] {
                        return false
                    }
                }
            }
            return true
        }
    }
}
