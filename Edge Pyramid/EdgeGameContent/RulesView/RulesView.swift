import SwiftUI

struct RulesView: View {
    
    @EnvironmentObject var userOptions: UserOptions
    
    @Environment(\.presentationMode) var preseMode
    
    var finishRulesAction: () -> Void
    
    var rulesData = ["rules_text_1", "rules_text_2", "rules_text_3", "rules_text_4", "rules_text_5"]
    @State var currentRulesDataIndex = 0
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer().frame(width: 90)
                
                Image("rules_title")
                
                Spacer()
                
                Button {
                    preseMode.wrappedValue.dismiss()
                } label: {
                    Image("home_btn")
                }
            }
            .padding([.leading, .trailing, .top])
            
            Spacer()
                           
            Image(rulesData[currentRulesDataIndex])
                .zIndex(3)
            
            Button {
                if currentRulesDataIndex < rulesData.count - 1 {
                    currentRulesDataIndex += 1
                } else {
                    finishRulesAction()
                }
            } label: {
                Image("arrow_forward2")
                    .zIndex(2)
            }
            .offset(y: -30)

            Spacer()
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
    RulesView(finishRulesAction: { })
        .environmentObject(UserOptions())
}
