//
//  SettingsView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import SwiftUI


struct SettingsView: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image(.gameBg)
                .resizable()
                .ignoresSafeArea()
            VStack {
                
                HStack {
                    BackButtonView()

                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    
                    Text("Options")
                        .font(.custom("JotiOne-Regular", size: 40))
                        .foregroundColor(.red)
                        .shadow(color: .black, radius: 5)
                    
                    Toggle(isOn: $settingsViewModel.isVibrationEnabled) {
                        Text("Vibration")
                            .font(.custom("JotiOne-Regular", size: 30))
                            .foregroundColor(.white)
                    }
                    .toggleStyle(SwitchToggleStyle(tint: Color.red))
                    .padding()
                    .background(
                        Capsule()
                            .foregroundColor(.darkRed)
                    )
                    .padding()
                    
                }
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    SettingsView()
}
