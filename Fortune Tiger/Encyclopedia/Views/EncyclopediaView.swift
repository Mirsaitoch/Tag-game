//
//  EncyclopediaView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 21.05.2024.
//

import SwiftUI

struct EncyclopediaView: View {
    
    var body: some View {
        ZStack {
            Image(.encyclopediaBg)
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                HeaderEncyclopediaView()
                VStack(alignment: .leading) {
                    ForEach(Consts.tigerNames, id: \.self) { name in
                        NavigationLink {
                            EncyclopediaDetailView(name: name)
                        } label: {
                            Text(name)
                                .foregroundColor(.red)
                                .font(.custom("JotiOne-Regular", size: 30, relativeTo: .headline))
                                .shadow(color: .white, radius: 1)
                                .padding(.leading, 15)
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        EncyclopediaView()
    }
}
