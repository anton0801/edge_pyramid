import SwiftUI

struct GameMenuView: View {
    
    @State var userOptions: UserOptions = UserOptions()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    NavigationLink(destination: ShopView()
                        .environmentObject(userOptions)
                        .navigationBarBackButtonHidden(true)) {
                        Image("shop_btn")
                    }
                    Spacer()
                }
                .padding()
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        Image("pers")
                    }
                    Spacer()
                    NavigationLink(destination: SettingsView()
                        .environmentObject(userOptions)
                        .navigationBarBackButtonHidden(true)) {
                        Image("settings_btn")
                    }
                    .offset(y: -50)
                    Spacer()
                    NavigationLink(destination: LevelsView()
                        .environmentObject(userOptions)
                        .navigationBarBackButtonHidden(true)) {
                        Image("play_btn")
                    }
                    .offset(y: -50)
                    Spacer()
                    Button {
                        exit(0)
                    } label: {
                        Image("exit_btn")
                    }
                    .offset(y: -50)
                    Spacer()
                    VStack {
                        Spacer()
                        Image("pers")
                    }
                }
            }
            .ignoresSafeArea()
            .background(
                Image(userOptions.background)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

#Preview {
    GameMenuView()
}
