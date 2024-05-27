//
//  LevelsView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import SwiftUI

struct LevelsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Image("game_bg")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    BackButtonView()

                    Spacer()
                    
                    SettingsButtonView()
                }
                Spacer()
                LevelsListView()
                Spacer()
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}


struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    var body: Content {
        build()
    }
}


#Preview {
    LevelsView()
}
