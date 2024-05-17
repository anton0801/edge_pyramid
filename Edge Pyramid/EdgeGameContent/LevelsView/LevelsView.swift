import SwiftUI

struct LevelsView: View {
    
    @EnvironmentObject var userOptions: UserOptions
    
    @Environment(\.presentationMode) var preseMode
    
    @State var levelsGridColumns: [GridItem] = []
    
    @State var levels: [[LevelItem]] = []
    
    @State var currentPage = 0
    var levelRows = 3
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Spacer().frame(width: 100)
                    
                    Button {
                        levelsPrevPage()
                    } label: {
                        Image("arrow_back")
                    }
                    
                    Image("levels_title")
                    
                    Button {
                        levelsNextPage()
                    } label: {
                        Image("arrow_forward")
                    }
                    
                    Spacer()
                    
                    Button {
                        preseMode.wrappedValue.dismiss()
                    } label: {
                        Image("home_btn")
                    }
                    .padding(.trailing)
                }
                .padding([.trailing,.leading,.top])
                
                Spacer()
                
                LazyVGrid(columns: levelsGridColumns, spacing: 12) {
                    if !levels.isEmpty {
                        ForEach(levels[currentPage], id: \.id) { levelItem in
                            NavigationLink(destination: GameView(level: levelItem)
                                .environmentObject(userOptions)
                                .navigationBarBackButtonHidden(true)) {
                                ZStack {
                                    Image("level_item_bg")
                                    Text("\(levelItem.levelNum)")
                                        .font(.custom("IndicoRegular", size: 42))
                                        .padding(.top, 8)
                                        .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                                }
                            }
                        }
                    }
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
            .onAppear {
                splittedArray()
                calculateLevelsToShow()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func levelsPrevPage() {
        if currentPage > 0 {
            currentPage -= 1
            calculateLevelsToShow()
        }
    }
    
    private func levelsNextPage() {
        if currentPage < levels.count {
            currentPage += 1
            calculateLevelsToShow()
        }
    }
    
    private func calculateLevelsToShow() {
        let currentPageLevels = levels[currentPage]
        if currentPageLevels.count <= 9 {
            setGrid(3)
        } else if currentPageLevels.count <= 12 {
            setGrid(4)
        } else if currentPageLevels.count <= 15 {
            setGrid(5)
        }
    }
    
    private func setGrid(_ rows: Int) {
        levelsGridColumns = []
        for _ in 0..<rows {
            levelsGridColumns.append(GridItem(.fixed(80), spacing: 40))
        }
    }
    
    private func splittedArray() {
        var partLevels = [LevelItem]()
        for (index, level) in gameLevels.enumerated() {
            partLevels.append(level)
            if index == 14 || index == gameLevels.count - 1 {
                levels.append(partLevels)
                partLevels = []
            }
        }
    }
    
}

#Preview {
    LevelsView()
        .environmentObject(UserOptions())
}
