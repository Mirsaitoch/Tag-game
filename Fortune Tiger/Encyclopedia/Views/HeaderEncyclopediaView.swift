//
//  HeaderEncyclopediaView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 27.05.2024.
//

import SwiftUI

struct HeaderEncyclopediaView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        HStack {
            BackButtonView()
            
            Spacer()
            
            ZStack {
                Capsule()
                    .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 20)
                    .foregroundColor(.darkRed)
                
                
                Text("Encyclopedia")
                    .font(.custom("JotiOne-Regular", size: 15))
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            SettingsButtonView()
        }

    }
}

#Preview {
    HeaderEncyclopediaView()
}
