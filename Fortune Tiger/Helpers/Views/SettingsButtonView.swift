//
//  SettingsButtonView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 27.05.2024.
//

import SwiftUI

struct SettingsButtonView: View {
    var body: some View {
        NavigationLink(destination: SettingsView(), label: {
            Image(.settings)
                .resizable()
                .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                .padding(.horizontal, 20)
        })
    }
}

#Preview {
    SettingsButtonView()
}
