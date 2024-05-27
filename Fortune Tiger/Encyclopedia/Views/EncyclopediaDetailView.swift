//
//  EncyclopediaDetailView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 26.05.2024.
//

import SwiftUI

struct EncyclopediaDetailView: View {
    @State var name: String
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            Image(.encyclopediaBg)
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HStack {
                    Button {
                        self.presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image("back")
                            .resizable()
                            .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                            .padding(.horizontal, 20)
                    }
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
                    
                    NavigationLink(destination: SettingsView(), label: {
                        Image("settings")
                            .resizable()
                            .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                            .padding(.horizontal, 20)
                    })
                }
                
                VStack(alignment: .center) {
                    Image(name)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(60)
                    ScrollView(showsIndicators: false) {
                        Text(Consts.tigerDescriptions[name] ?? "NaN")
                            .font(.custom("JotiOne-Regular", size: 20))
                            .foregroundColor(.white)
                            .padding(.horizontal)
                    }
                    Spacer()

                }
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

#Preview {
    EncyclopediaDetailView(name: "Amur tiger")
}
