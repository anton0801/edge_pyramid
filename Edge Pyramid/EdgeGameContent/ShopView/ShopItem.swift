import Foundation

struct ShopItem {
    var id: String
    var item: String
    var type: ShopItemType
    var price: Int
}

enum ShopItemType {
    case booster, map
}

var shopItems = [
    ShopItem(id: "time_booster", item: "b_time", type: .booster, price: 15),
    ShopItem(id: "game_back_1", item: "game_back_1", type: .map, price: 25),
    ShopItem(id: "game_back_2", item: "game_back_2", type: .map, price: 25),
    ShopItem(id: "game_back_3", item: "game_back_3", type: .map, price: 25),
    ShopItem(id: "game_back_4", item: "game_back_4", type: .map, price: 25),
    ShopItem(id: "game_back_5", item: "game_back_5", type: .map, price: 25)
]
