import SwiftUI
import SpriteKit

struct GameView: View {
    
    @Environment(\.presentationMode) var preseMode
    
    @EnvironmentObject var userOptions: UserOptions
    
    var level: LevelItem
    
    @State var showWin = false
    @State var showLose = false
    @State var gamePause = false
    
    @State private var edgeGameScene: EdgeGameScene = EdgeGameScene()
    
    @State var rulesGameVisible = UserDefaults.standard.bool(forKey: "rules_passed") {
        didSet {
            UserDefaults.standard.set(true, forKey: "rules_passed")
        }
    }
    
    var body: some View {
        if !rulesGameVisible {
            RulesView(finishRulesAction: {
                withAnimation(.linear(duration: 0.5)) {
                    rulesGameVisible = true
                }
            })
            .environmentObject(userOptions)
        } else {
            ZStack {
                SpriteView(scene: edgeGameScene)
                    .ignoresSafeArea()
                    .onAppear {
                        edgeGameScene.level = level
                    }
                if gamePause {
                    pauseView
                } else if showWin {
                    winView
                } else if showLose {
                    loseView
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("PAUSE_GAME"))) { _ in
                withAnimation {
                   gamePause = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("LOSE_GAME"))) { _ in
                withAnimation {
                   showLose = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("GAME_WIN"))) { _ in
                let pauntsAll = userOptions.paunts
                let totalPaunts = pauntsAll + 5
                userOptions.paunts = totalPaunts
                withAnimation {
                   showWin = true
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("RESTART_GAME"))) { _ in
                edgeGameScene = edgeGameScene.restartGame()
            }
        }
    }
    
    private var pauseView: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                Spacer().frame(width: 100)
                
                Image("pause_title")
                
                Spacer()
                
                Button {
                    preseMode.wrappedValue.dismiss()
                } label: {
                    Image("home_btn")
                }
                .padding(.trailing)
            }
            .padding([.trailing,.leading,.top])
            
            Image("pause_content")
                .zIndex(3)
            
            Button {
                withAnimation(.linear(duration: 0.5)) {
                    gamePause = false
                    edgeGameScene.contunueGame()
                }
            } label: {
                Image("arrow_forward2")
            }
            .offset(y: -30)
            .zIndex(4)
        }
        .ignoresSafeArea()
        .background(
            Image(userOptions.background)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
    
    private var winView: some View {
        VStack {
            HStack {
                Spacer()
                
                Image("win_title")
                
                Spacer()
            
            }
            .padding([.trailing,.leading,.top])
            
            Spacer()
            
            HStack {
                Spacer()
                Button {
                    preseMode.wrappedValue.dismiss()
                } label: {
                    Image("home_btn")
                }
                Spacer()
                
                Image("win_content")
                    .zIndex(3)
                
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.5)) {
                        edgeGameScene = edgeGameScene.restartGame()
                        showWin = false
                    }
                } label: {
                    Image("restart_btn")
                }
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(
            Image(userOptions.background)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
    
    private var loseView: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Image("lose_title")
                
                Spacer()
            
            }
            .padding([.trailing,.leading,.top])
            
            HStack {
                Spacer()
                Button {
                    preseMode.wrappedValue.dismiss()
                } label: {
                    Image("home_btn")
                }
                Spacer()
                
                Image("lose_content")
                    .zIndex(3)
                
                Spacer()
                Button {
                    withAnimation(.linear(duration: 0.5)) {
                        edgeGameScene = edgeGameScene.restartGame()
                        showLose = false
                    }
                } label: {
                    Image("restart_btn")
                }
                Spacer()
            }
            Spacer()
        }
        .ignoresSafeArea()
        .background(
            Image(userOptions.background)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
    
}

#Preview {
    GameView(level: gameLevels[0])
        .environmentObject(UserOptions())
}
