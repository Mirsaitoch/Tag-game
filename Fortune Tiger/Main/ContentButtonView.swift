//
//  ContentButtonView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 27.05.2024.
//

import SwiftUI

struct ContentButtonView: View {
    let text: String
    let color: Color
    var body: some View {
        HStack {
            Text("\(text)")
                .font(.custom("JotiOne-Regular", size: 20))
        }
        .foregroundColor(.white)
        .padding(20)
        .background(
            Capsule()
                .foregroundColor(color)
        )
        .frame(width: UIScreen.main.bounds.width / 2)

    }
}

#Preview {
    ContentButtonView(text: "Start game", color: .newYellow)
}
