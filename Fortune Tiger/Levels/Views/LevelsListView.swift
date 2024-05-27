//
//  LevelsListView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 27.05.2024.
//

import SwiftUI

struct LevelsListView: View {
    @EnvironmentObject var levelsViewModel: LevelsViewModel
    var body: some View {
        VStack {
            NavigationLink(destination: LazyView(GameView(size: 3, levelsViewModel: levelsViewModel))) {
                LevelButtonView(text: "3 x 3", isClosed: levelsViewModel.levels[0].isClosed)
            }
            .disabled(levelsViewModel.levels[0].isClosed)

            
            NavigationLink(destination: LazyView(GameView(size: 4, levelsViewModel: levelsViewModel))) {
                LevelButtonView(text: "4 x 4", isClosed: levelsViewModel.levels[1].isClosed)
            }
            .disabled(levelsViewModel.levels[1].isClosed)

            
            NavigationLink(destination: LazyView(GameView(size: 5, levelsViewModel: levelsViewModel))) {
                LevelButtonView(text: "5 x 5", isClosed: levelsViewModel.levels[2].isClosed)
            }
            .disabled(levelsViewModel.levels[2].isClosed)

        }
    }
}

#Preview {
    LevelsListView()
}
