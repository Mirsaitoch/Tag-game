//
//  LevelButtonView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import SwiftUI

struct LevelButtonView: View {
    let text: String
    let isClosed: Bool
    var body: some View {
        HStack {
            Text("\(text)")
                .font(.custom("JotiOne-Regular", size: 30))
            if isClosed {
                Image(systemName: "lock.fill")
                    .font(.system(size: 25))
            }
        }
        .foregroundColor(.white)
        .padding(.vertical, 20)
        .padding(.horizontal, 50)
        .background(
            Capsule()
                .foregroundColor(.darkRed)
        )
    }
}

#Preview {
    LevelButtonView(text: "3 X 3", isClosed: true)
}
