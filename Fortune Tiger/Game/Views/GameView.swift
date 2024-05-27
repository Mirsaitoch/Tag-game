//
//  GameView.swift
//  Fortune Tiger
//
//  Created by Мирсаит Сабирзянов on 25.05.2024.
//

import SwiftUI
import SwiftImage

struct GameView: View {
    @StateObject private var viewModel: GameView.ViewModel
    
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var levelsViewModel: LevelsViewModel
    @State var size: Int
    
    init(size: Int, levelsViewModel: LevelsViewModel) {
        self.size = size
        Consts.rows = size
        Consts.columns = size

        let viewModel = ViewModel(levelsViewModel: levelsViewModel)
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @ViewBuilder
    func cell(_ dataCoord: Coord) -> some View {
        if let imageCoord = viewModel.getData(at: dataCoord) {
            // Проверка границ массива
            if imageCoord.x < viewModel.imageParts.count && imageCoord.y < viewModel.imageParts[imageCoord.x].count {
                Image(uiImage: viewModel.imageParts[imageCoord.x][imageCoord.y])
                    .resizable()
                    .onTapGesture {
                        let freeCoord = viewModel.freeCoord
                        switch (abs(freeCoord.x - dataCoord.x), abs(freeCoord.y - dataCoord.y)) {
                        case (1, 0), (0, 1):
                            withAnimation {
                                viewModel.swap(dataCoord, freeCoord)
                                viewModel.updateGameStatus()
                            }
                        default: break
                        }
                        
                        if settingsViewModel.isVibrationEnabled {
                            let generator = UIImpactFeedbackGenerator(style: .medium)
                            generator.impactOccurred()
                        }
                        
                    }
            } else {
                Color.clear
            }
        } else {
            Color.clear
        }
    }
    
    @ViewBuilder
    var body: some View {
        ZStack {
            Image(.gameBg)
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                HStack { 
                    BackButtonView()
                    
                    Spacer()
                    
                    ZStack {
                        Capsule()
                            .frame(width: UIScreen.main.bounds.width / 3, height: UIScreen.main.bounds.height / 20)
                            .foregroundColor(.darkRed)
                        
                        HStack {
                            Image(systemName: "deskclock.fill")
                            Text(viewModel.remainingTimeString)
                        }
                        .font(.custom("JotiOne-Regular", size: 25))
                        .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    SettingsButtonView()
                        .simultaneousGesture(TapGesture().onEnded {
                        viewModel.pauseGame()
                    })
                }
                
                Text(viewModel.name)
                    .foregroundColor(.red)
                    .bold()
                    .font(.custom("JotiOne-Regular", size: 30, relativeTo: .headline))
                    .shadow(color: .black, radius: 5)
                
                Spacer()
                
                ZStack {
                    Image("cell_bg")
                        .resizable()
                        .frame(height: UIScreen.main.bounds.height / 2.3)
                    
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        VStack(spacing: Consts.rowsSpacing) {
                            ForEach(0..<Consts.rows, id: \.self) { y in
                                HStack(spacing: Consts.columnsSpacing) {
                                    ForEach(0..<Consts.columns, id: \.self) { x in
                                        cell(.init(x, y)).frame(maxWidth: .infinity, maxHeight: .infinity)
                                    }
                                }
                            }
                        }
                        .frame(height: UIScreen.main.bounds.height / 2.5)
                        .padding()
                        .disabled(!viewModel.isPlay)
                        .opacity(viewModel.isPlay ? 1 : 0.5)
                        
                        if !viewModel.isPlay || viewModel.gameIsEnded {
                            GameStatusCellView(text: viewModel.statusGameText)
                        }
                        
                        Spacer()
                    }
                }
                .padding()
                
                ZStack {
                    Image("cell_bg")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 3)
                    Image(viewModel.name)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 2))
                        .frame(width: UIScreen.main.bounds.width / 4)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    NavigationLink(destination: EncyclopediaDetailView(name: viewModel.name), label: {
                        Image(.info)
                            .resizable()
                            .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                            .padding(.horizontal, 20)
                    }).simultaneousGesture(TapGesture().onEnded {
                        viewModel.pauseGame()
                    })
                    
                    if viewModel.gameIsEnded {
                        Button {
                            viewModel.restart()
                        } label: {
                            Image(.restart)
                                .resizable()
                                .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                                .padding()
                        }
                    } else {
                        Button {
                            viewModel.isPlay ? viewModel.pauseGame() : viewModel.continueGame()
                        } label: {
                            Image(viewModel.isPlay ? "pause" : "play")
                                .resizable()
                                .frame(width: Consts.buttonSize, height: Consts.buttonSize)
                                .padding()
                        }
                    }
                    
                    Spacer()
                }
            }
            .onReceive(timer) { _ in
                if viewModel.remainingTime > 0 && viewModel.isPlay {
                    viewModel.remainingTime -= 1
                }
                
                if viewModel.remainingTime <= 0 && viewModel.isPlay {
                    viewModel.looser()
                }
            }
            .onAppear {
                Task {
                    if !viewModel.roundIsStarted {
                        await viewModel.loadImageParts(name: viewModel.name)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NavigationView {
        GameView(size: 3, levelsViewModel: LevelsViewModel())
    }
}
