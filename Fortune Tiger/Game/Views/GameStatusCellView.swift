//
//  GameStatusCellView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import SwiftUI

struct GameStatusCellView: View {
    let text: String
    var body: some View {
        ZStack {
            Capsule()
                .frame(width: UIScreen.main.bounds.width / 2, height: UIScreen.main.bounds.height / 15)
                .foregroundColor(.darkRed)
            Text(text)
                .font(.custom("JotiOne-Regular", size: 30))
                .foregroundColor(.white)
        }
    }
}

#Preview {
    GameStatusCellView(text: "Active")
}
