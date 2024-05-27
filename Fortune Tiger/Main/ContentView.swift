//
//  ContentView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
                ZStack {
                    Image("bg")
                        .resizable()
                        .ignoresSafeArea()
                    VStack {
                        Spacer()
                        
                        HStack {

                            NavigationLink(destination: LevelsView()) {
                                ContentButtonView(text: "Start game", color: .newYellow)
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: EncyclopediaView()) {
                                ContentButtonView(text: "Encyclopedia", color: .darkRed)
                            }
                        }
                    }
                }
            }
            .navigationBarHidden(true)
    }
}

#Preview {
    ContentView()
}
