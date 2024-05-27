//
//  BackButtonView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 27.05.2024.
//

import SwiftUI

struct BackButtonView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image("back")
                .resizable()
                .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                .padding(.horizontal, 20)
        }
    }
}

#Preview {
    BackButtonView()
}
