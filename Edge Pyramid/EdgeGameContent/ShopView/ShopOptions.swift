import Foundation

class ShopOptions: ObservableObject {
    
    @Published var shopItemsInStock: [ShopItem] = []
    
    func obtainAllStockedItems() {
        let stockedItemsList = UserDefaults.standard.string(forKey: "stocked_items")?.components(separatedBy: ",") ?? []
        for stock in stockedItemsList {
            shopItemsInStock.append(shopItems.filter { $0.id == stock }[0])
        }
    }
    
    func buyShopItem(userOptions: UserOptions, shopItem: ShopItem) -> Bool {
        let paunts = userOptions.paunts
        if paunts >= shopItem.price {
            userOptions.paunts = paunts - shopItem.price
            shopItemsInStock.append(shopItem)
            UserDefaults.standard.set(shopItemsInStock.map { $0.id }.joined(separator: ","), forKey: "stocked_items")
            return true
        }
        return false
    }
    
}
