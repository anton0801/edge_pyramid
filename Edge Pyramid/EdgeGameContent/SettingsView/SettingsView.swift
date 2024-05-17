import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var preseMode
    
    @EnvironmentObject var userOptions: UserOptions
    
    @State var musicOn = UserDefaults.standard.bool(forKey: "musicOn")
    @State var soundsOn = UserDefaults.standard.bool(forKey: "soundsOn")
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Image("settings_title")
                    .offset(x: 50)
                Spacer()
                Button {
                   preseMode.wrappedValue.dismiss()
                } label: {
                   Image("home_btn")
                }
                .padding(.trailing)
            }
            
            Spacer()
            
            VStack {
                HStack {
                    Image("ic_sound")
                    VStack(alignment: .leading) {
                        Text("SOUNDS")
                            .font(.custom("IndicoRegular", size: 20))
                           .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                           .shadow(color: .white, radius: 4)
                        ZStack {
                            Button {
                                withAnimation(.linear(duration: 0.5)) {
                                    soundsOn = !soundsOn
                                }
                            } label: {
                                if soundsOn {
                                    Image("settings_slider_full")
                                } else {
                                    Image("settings_slider_empty")
                                }
                            }
                        }
                        .frame(width: 130)
                    }
                }
                
                HStack {
                    Image("ic_music")
                    VStack(alignment: .leading) {
                        Text("MUSIC")
                            .font(.custom("IndicoRegular", size: 20))
                           .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                           .shadow(color: .white, radius: 4)
                        ZStack {
                            Button {
                                withAnimation(.linear(duration: 0.5)) {
                                    musicOn = !musicOn
                                }
                            } label: {
                                if musicOn {
                                    Image("settings_slider_full")
                                } else {
                                    Image("settings_slider_empty")
                                }
                            }
                        }
                        .frame(width: 130)
                    }
                }
                .padding(.top)
            }
            .background(
                Image("settings_bg")
            )
            Button {
                UserDefaults.standard.set(musicOn, forKey: "musicOn")
                UserDefaults.standard.set(soundsOn, forKey: "soundsOn")
                preseMode.wrappedValue.dismiss()
            } label: {
                Image("select_btn")
            }
            
            Spacer()
        }
        .onAppear {
        }
        .background(
            Image(userOptions.background)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SettingsView()
        .environmentObject(UserOptions())
}
