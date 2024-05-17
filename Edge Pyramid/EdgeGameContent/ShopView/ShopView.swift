import SwiftUI

struct ShopView: View {
    
    @Environment(\.presentationMode) var preseMode
    
    @EnvironmentObject var userOptions: UserOptions
    @StateObject var shopOptions: ShopOptions = ShopOptions()
    
    @State var currentShopItem: ShopItem = shopItems[0]
    @State var currentShopItemIndex = 0
    @State var background = ""
    
    @State var buyItemStatus = false
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Text("\(userOptions.paunts)")
                        .font(.custom("IndicoRegular", size: 24))
                        .padding(.top, 8)
                        .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                    Image("coin")
                }
                .background(
                    Image("coins_bg")
                        .resizable()
                        .frame(width: 150, height: 60)
                )
                .padding(.leading, 50)
                Spacer()
                Text(currentShopItem.type == .map ? "MAP" : "TIME")
                    .font(.custom("IndicoRegular", size: 42))
                    .padding(.top, 8)
                    .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                    .offset(x: -20)
                Spacer()
                Button {
                   preseMode.wrappedValue.dismiss()
                } label: {
                   Image("home_btn")
                }
                .padding(.trailing)
            }
            
            HStack {
                Button {
                    if currentShopItemIndex > 0 {
                        currentShopItemIndex -= 1
                        currentShopItem = shopItems[currentShopItemIndex]
                        if currentShopItemIndex == 0 {
                            background = userOptions.background
                        }
                        if currentShopItem.type == .map {
                            background = currentShopItem.item
                        }
                    }
                } label: {
                    Image("arrow_back")
                }
                
                Spacer()
                
                VStack {
                    if !shopOptions.shopItemsInStock.contains(where: { $0.id == currentShopItem.id }) {
                        Button {
                            buyItemStatus = !shopOptions.buyShopItem(userOptions: userOptions, shopItem: currentShopItem)
                        } label: {
                            ZStack {
                                Image("coins_bg")
                                HStack(spacing: 2) {
                                    Text("\(currentShopItem.price)")
                                          .font(.custom("IndicoRegular", size: 40))
                                          .padding(.top, 8)
                                          .foregroundColor(Color.init(red: 86/255, green: 6/255, blue: 11/255))
                                    Image("coin")
                                }
                            }
                        }
                    }
                    
                    Spacer()
                    
                    if currentShopItem.type == .booster {
                        Image(currentShopItem.item)
                    }
                    
                    Spacer()
                    
                    if shopOptions.shopItemsInStock.contains(where: { $0.id == currentShopItem.id }) {
                        Button {
                            userOptions.background = currentShopItem.item
                        } label: {
                            Image("select_btn")
                        }
                    }
                    
                }
                
                Spacer()
                
                Button {
                    if currentShopItemIndex < shopItems.count - 1 {
                        currentShopItemIndex += 1
                        currentShopItem = shopItems[currentShopItemIndex]
                        if currentShopItem.type == .map {
                            background = currentShopItem.item
                        }
                    }
                } label: {
                    Image("arrow_forward")
                }
            }
            .padding([.leading, .trailing], 50)
            
        }
        .ignoresSafeArea()
        .background(
            Image(background)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
        )
        .onAppear {
            background = userOptions.background
            shopOptions.obtainAllStockedItems()
        }
        .alert(isPresented: $buyItemStatus) {
            Alert(
                title: Text("Buy item error"),
                message: Text("Looks like you don't have enough coins to buy this item, go through more levels to buy this item!"),
                dismissButton: .cancel(Text("OK!"))
            )
        }
    }
}

#Preview {
    ShopView()
        .environmentObject(UserOptions())
}
